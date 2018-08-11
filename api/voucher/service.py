from app01 import models
from utils.utils import transaction_wrapper


@transaction_wrapper
def record_reward_member_voucher(member, reward_vouchers):
    """ Record the voucher obtained by this member"""
    objs = []
    for i in reward_vouchers:
        obj = models.Voucher_Member(**{'member': member, 'voucher': i, 'status': 0})
        objs.append(obj)
    models.Voucher_Member.objects.bulk_create(objs)


@transaction_wrapper
def record_redeemed_member_voucher(member, redeemed_vouchers):
    """ Record the voucher redeemed by this member"""
    for voucher in redeemed_vouchers:
        obj = models.Voucher_Member.objects.filter(member=member, voucher=voucher, status=0).order_by('created').first()
        if obj:
            obj.status = 1
            obj.save()
