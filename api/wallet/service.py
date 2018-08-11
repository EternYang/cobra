from app01 import models
from utils.utils import transaction_wrapper
from django.db.models import Count
from member.services import update_membership, update_points
from voucher.service import record_reward_member_voucher
from campaign.service import insert_member_campaigntype, get_meet_campaigns_for_top_up


@transaction_wrapper
def recharge(recharge_record):
    """ Some passive business logic will be triggered by the recharged action"""
    wallet = recharge_record.wallet
    member = wallet.member
    top_up_money = recharge_record.money

    # 1.Update wallet balance and lastest_top_up
    wallet.balance += top_up_money
    wallet.lastest_top_up = recharge_record.created
    wallet.save()

    # 2.Campaign recharge reward (with every $x top up to E-wallet)
    # 2.1 Determine if the campaign conditions are met, and get all meet campaigns
    meet_campaigns = get_meet_campaigns_for_top_up(member)

    # 2.2 Calculate all campaign rewards
    campaign_types = models.CampaignType.objects.filter(campaign__in=meet_campaigns).all()
    for campaign_type in campaign_types:
        # 2.2.1 Check if the number of rewards is exceeded
        limit_redemption = campaign_type.campaign_condition.limit_redemption
        if limit_redemption:
            count = models.Member_CampaignType.objects.filter(member=member, campaign_type=campaign_type).aggregate(
                count=Count('id')).get('count')
            # print(count, limit_redemption)
            if count >= limit_redemption:
                return
        insert_member_campaigntype(member, [campaign_type])
        # 2.2.2 update member points_bal, insert Points_Member record
        if campaign_type.campaign_condition.every_top_up:
            every_top_up = campaign_type.campaign_condition.every_top_up
            if campaign_type.bouns_points:
                bouns_points = campaign_type.bouns_points
                reward_count = int(top_up_money // every_top_up)
                total_reward_points = reward_count * bouns_points
                update_points(member, total_reward_points, 2, campaigntype=campaign_type)
                # print(total_reward_points)
        # 2.2.3 upgrade membership level
        if campaign_type.top_up_money and campaign_type.upgrade_membership:
            top_up_money_for_upgrade = campaign_type.top_up_money
            upgrade_membership_start_points = campaign_type.upgrade_membership.start_points
            if wallet.member.membership.start_points < upgrade_membership_start_points and top_up_money >= top_up_money_for_upgrade:
                update_membership(member, campaign_type.upgrade_membership)
                # print(upgrade_membership)
        # 2.2.4 free vouchers for this campaign
        if campaign_type.free_vouchers.all():
            free_vouchers = campaign_type.free_vouchers.all()
            record_reward_member_voucher(member, free_vouchers)
            # print(free_vouchers)
