from app01 import models
from datetime import datetime
from member.services import update_membership, update_points
from django.db.models import Count
from django.db import transaction
from voucher.service import record_reward_member_voucher


def daily():
    """ Executed at 00:00:02 every day"""
    # 1.Check campaign state
    models.Campaign.objects.exclude(state__in=[models.Campaign.processing, models.Campaign.archived]).filter(
        effective_date__gte=datetime.now(), expiring_date__gte=datetime.now()).update(state=1)
    models.Campaign.objects.exclude(state__in=[models.Campaign.processing, models.Campaign.archived]).filter(
        effective_date__lte=datetime.now(), expiring_date__gte=datetime.now()).update(state=2)
    models.Campaign.objects.exclude(state__in=[models.Campaign.processing, models.Campaign.archived]).filter(
        effective_date__lte=datetime.now(), expiring_date__lte=datetime.now()).update(state=3)

    # 2.Check voucher state and Voucher_Member state
    models.Voucher.objects.filter(effective_date__gte=datetime.now(), expiring_date__gte=datetime.now()).update(state=1)
    models.Voucher.objects.filter(effective_date__lte=datetime.now(), expiring_date__gte=datetime.now()).update(state=2)
    models.Voucher.objects.filter(effective_date__lte=datetime.now(), expiring_date__lte=datetime.now()).update(state=3)
    models.Voucher_Member.objects.filter(voucher__effective_date__lte=datetime.now(),
                                         voucher__expiring_date__lte=datetime.now()).update(status=2)

    # 3.Change in membership level cycle
    membership_members = models.Membership_Member.objects.filter(status=0, expiring_date__lte=datetime.now()).all()
    members = []
    # 3.1 will execute downgrade one level
    with transaction.atomic():
        for membership_member in membership_members:
            member = membership_member.member
            members.append(member)
            desc_memberships = models.Membership.objects.order_by('-start_points').all()
            for membership in desc_memberships:
                if member.total_points <= member.membership.renewal_points:
                    if 0 > member.membership.start_points < membership.start_points:
                        update_membership(member, membership)
                        break

    # 3.2 will automatic exchange of vouchers for one year and clear the points(points_bal and total_points)
    with transaction.atomic():
        reward_vouchers = []
        for member in members:
            total_num_products = models.Product.objects.all().count()
            # get Any one drink(M) voucher
            voucher = models.Voucher.objects.annotate(num=Count('redemption_products')).filter(state=2,
                                                                                               num=total_num_products)
            if voucher.exists():
                voucher = voucher.first()
            else:
                lastest_id = models.Voucher.objects.only('id').latest('id').pk
                voucher = models.Voucher.objects.create(
                    name='Any one drink(M)-%s' % (datetime.now().strftime('%Y-%m-%d %H:%M:%S')), type=0,
                    voucher_code='any_one_drink(M)-%05d' % (lastest_id + 1),
                    effective_date='2018-01-01', expiring_date='2099-01-01',
                    redemption_points=9999, product_size=[0], product_number=1,
                    state=2)
                voucher.redemption_products.set(models.Product.objects.all())
                voucher.save()
            count_redeemed = int(member.points_bal // member.membership.complimentary_m_drink_points)
            update_points(member, -member.points_bal, 4)
            for i in range(count_redeemed):
                reward_vouchers.append(voucher)
            record_reward_member_voucher(member, reward_vouchers)


def monthly():
    """ Execute at 00:00:02 every month on the 1st"""
    # 1.Birthday voucher for the month of the month
    with transaction.atomic():
        if datetime.now().day == 1:
            members = models.Member.objects.filter(dob__month=datetime.now().month).all()
            for member in members:
                vouchers = member.membership.birthday_vouchers.all()
                record_reward_member_voucher(member, vouchers)
