from app01 import models
from datetime import datetime
from django.db.models import Avg, Sum, Count
from member.services import update_membership
from utils.utils import transaction_wrapper


def get_launched_campaigns():
    return models.Campaign.objects.filter(state=2).all()


def get_launched_campaign_types():
    pass


def get_launched_campaign_conditions():
    campaign_conditions = models.CampaignCondition.objects.filter(campaigntype__campaign__state=2).all()
    return campaign_conditions


def get_meet_campaigns_for_top_up(member):
    """Determine if the campaign conditions are met, and return all meet campaigns"""
    campaigns = get_launched_campaigns().filter(campaigntypes__campaign_condition__every_top_up__isnull=False).all()
    meet_campaigns = []
    for campaign in campaigns:
        if campaign.occupations:
            pass
        if campaign.memberships:
            memberships = campaign.memberships.all()
            membership_ids = [membership.pk for membership in memberships]
            if member.membership.pk not in membership_ids:
                continue
        if campaign.gender:
            pass
        if campaign.min_age or campaign.max_age:
            pass
        if campaign.days_of_month:
            day = datetime.now().day
            if day not in campaign.days_of_month:
                continue
        if campaign.repetition_periods:
            weekday = datetime.now().weekday() + 1
            if 0 not in campaign.repetition_periods:
                if weekday not in campaign.repetition_periods:
                    continue
        meet_campaigns.append(campaign)
    return meet_campaigns


def get_meet_campaigns_for_purchase(transaction):
    member = transaction.member
    meet_campaigns = get_meet_campaigns_for_top_up(member)
    new_meet_campaigns = []
    for campaign in meet_campaigns:
        if campaign.outlets:
            outlet_ids = [outlet.pk for outlet in campaign.outlets.all()]
            if transaction.outlet.pk not in outlet_ids:
                continue
        new_meet_campaigns.append(campaign)
    return new_meet_campaigns


@transaction_wrapper
def insert_member_campaigntype(member, campaigntypes):
    """ Insert the campaign type record that the member has participated in"""
    objs = []
    for i in campaigntypes:
        obj = models.Member_CampaignType(**{'member': member, 'campaign_type': i})
        objs.append(obj)
    models.Member_CampaignType.objects.bulk_create(objs)
