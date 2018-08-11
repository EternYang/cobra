from app01 import models
from django.conf import settings
from utils.utils import transaction_wrapper
from voucher.service import record_reward_member_voucher


@transaction_wrapper
def encrypted_or_reset_password(member, new_passwd):
    """encrypted password or reset password"""
    member.set_password(new_passwd)
    member.save()


@transaction_wrapper
def create_member(member):
    """Some passive business logic will be triggered by the creation of new members"""
    # 1.Encrypted password
    encrypted_or_reset_password(member, member.password)
    # 2.Free vouchers for this member membership level
    free_vouchers = member.membership.complimentary_vouchers.all()
    if free_vouchers:
        record_reward_member_voucher(member, free_vouchers)


@transaction_wrapper
def update_points(member, points_change, method, campaigntype=None, campaigntype_id=None):
    """Changes triggered by points change"""
    # 1.Record Points_Member
    if campaigntype:
        points_member = models.Points_Member.objects.create(member=member, points_number=points_change, method=method,
                                                            campaigntype=campaigntype)
    elif campaigntype_id:
        points_member = models.Points_Member.objects.create(member=member, points_number=points_change, method=method,
                                                            campaigntype_id=campaigntype_id)
    else:
        points_member = models.Points_Member.objects.create(member=member, points_number=points_change, method=method)
    # 2.Update member's points balance and total_points
    member.points_bal += points_change
    if points_member.method in (0, 1, 2):
        member.total_points += points_change
    elif points_member.method == 4:
        member.total_points = 0
    member.save()
    # 3.Upgrade membership
    desc_memberships = models.Membership.objects.order_by('-start_points').all()
    for membership in desc_memberships:
        if member.membership.start_points < membership.start_points <= member.total_points:
            update_membership(member, membership)
            break


@transaction_wrapper
def update_membership(member, new_membership):
    """Changes triggered by a member's membership level change"""
    # 1.Record and update Membership_Member
    member.membership_members.update(status=1)
    models.Membership_Member.objects.create(member=member, membership=new_membership, status=0)
    member.membership = new_membership
    member.save()
    # 2.Free vouchers for new membership level
    free_vouchers = member.membership.complimentary_vouchers.all()
    if free_vouchers:
        record_reward_member_voucher(member, free_vouchers)


@transaction_wrapper
def bind_email(validated_data, member):
    """Member can get bonus points by binding emails"""
    if validated_data.get('email') and not models.Points_Member.objects.filter(member=member, method=1).exists():
        reward_points = settings.BINDING_EMAIL.get('reward_points')
        if reward_points:
            update_points(member, reward_points, 1)


@transaction_wrapper
def supplement_info(validated_data, member):
    """Member's supplementary information can get bonus points"""
    if not models.Points_Member.objects.filter(member=member, method=0).exists():
        reward_points = settings.SUPPLEMENT_INFO.get('reward_points')
        if reward_points:
            update_points(member, reward_points, 0)


@transaction_wrapper
def update_member_last_purchase_date(member, date):
    member.last_purchase_date = date
    member.save()
