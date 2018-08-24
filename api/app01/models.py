from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from rest_framework.authtoken.models import Token as authToken
from django.utils import timezone
from django.contrib.postgres.fields import ArrayField
from datetime import datetime, timedelta
from django.conf import settings
from django.utils.translation import ugettext_lazy as _


def one_year_later():
    now = datetime.now()
    return now + timedelta(days=365)


class InterestGroup(models.Model):
    name = models.CharField('Interest Group name', max_length=32, unique=True)


class Role(models.Model):
    ADMIN, POS, MEMBER, ANONYMOUS, APP = range(5)
    NAME_CHOICES = (
        (ADMIN, 'ADMIN'),
        (POS, 'POS'),
        (MEMBER, 'MEMBER'),
        (ANONYMOUS, 'ANONYMOUS'),
        (APP, 'APP'),
    )
    name = models.PositiveSmallIntegerField(
        "Role name",
        choices=NAME_CHOICES,
        help_text="0:admin,1:pos,2:member,3:anonymous,4:app",
        unique=True
    )


class Membership(models.Model):
    # W, C, P = range(3)
    # LEVEL_CHOICES = (
    #     (W, 'Welcome membership'),
    #     (C, 'Classic membership'),
    #     (P, 'Premium membership'),
    # )
    # level = models.PositiveSmallIntegerField(
    #     "level",
    #     choices=LEVEL_CHOICES,
    #     help_text="0:Welcome membership,1:Classic membership,2:Premium membership",
    # )
    name = models.CharField('name', max_length=64)
    description = models.CharField('description', max_length=128, null=True, blank=True)
    complimentary_vouchers = models.ManyToManyField(to='Voucher', related_name='membership_compliment', null=True,
                                                    blank=True)
    birthday_vouchers = models.ManyToManyField(to='Voucher', related_name='membership_birthday', null=True, blank=True)
    start_points = models.IntegerField('start_points')
    # end_points = models.IntegerField('end_points')
    renewal_points = models.IntegerField('renewal_points')
    complimentary_m_drink_points = models.FloatField('start_points', null=True, blank=True)
    processing, launched, archived = range(3)
    STATE_CHOICES = (
        (processing, 'processing'),
        (launched, 'launched'),
        (archived, 'archived'),
    )
    state = models.PositiveSmallIntegerField(
        "state",
        choices=STATE_CHOICES,
        help_text="0:processing,1:launched,2:archived",
    )


class Member_CampaignType(models.Model):
    member = models.ForeignKey(to='Member', related_name='member_campaigntypes', on_delete=models.CASCADE)
    campaign_type = models.ForeignKey(to='CampaignType', related_name='member_campaigntypes', on_delete=models.CASCADE)
    created = models.DateTimeField('created', default=timezone.now)


class Member(AbstractBaseUser):
    TYPE = (
        (0, "未激活(no active)"),
        (1, "已激活(activation)")
    )
    USERNAME_FIELD = 'email'
    mobile_no = models.CharField('mobile_no', max_length=64, unique=True)
    registration_date = models.DateTimeField('registration_date', default=timezone.now)
    username = models.CharField('username', max_length=64, unique=True)
    password = models.CharField('password', max_length=128)
    last_login = models.DateTimeField('last login', blank=True, null=True)
    role = models.ForeignKey(to='Role', related_name='members', on_delete=models.CASCADE)
    interestGroups = models.ManyToManyField(to='InterestGroup', related_name='members', blank=True)
    membership = models.ForeignKey(to='Membership', related_name='members', on_delete=models.CASCADE)
    last_purchase_date = models.DateField('last_purchase_date', null=True, blank=True)
    vouchers = models.ManyToManyField(to='Voucher', through='Voucher_Member', through_fields=('member', 'voucher'))
    name = models.CharField('Member name', max_length=64, null=True, blank=True)
    points_bal = models.FloatField('points_bal', default=0)
    total_points = models.FloatField('total_points', default=0)
    dob = models.DateField('Member birthday', null=True, blank=True)
    telephone = models.CharField('telephone', max_length=64, null=True, blank=True)
    race = models.CharField('race', max_length=64, null=True, blank=True)
    email = models.EmailField('Member email', null=True, blank=True, unique=True)
    campaigntypes = models.ManyToManyField(to='CampaignType', through='Member_CampaignType',
                                           through_fields=('member', 'campaign_type'), related_name='members',
                                           blank=True)

    is_active = models.IntegerField(choices=TYPE, verbose_name="是否激活", default=0)
    nick_name = models.CharField(verbose_name="NickName", max_length=20, null=True, blank=True)

    class Meta:
        indexes = [
            models.Index(fields=['mobile_no'], name='mobile_no_idx'),
            models.Index(fields=['username'], name='username_idx'),
        ]
        # individual_position = models.CharField('Individual position', max_length=64, null=True, blank=True)
        # salutation = models.CharField('Member salutation', max_length=64, null=True, blank=True)
        # NRIC = models.CharField('Member NRIC', max_length=64, null=True, blank=True)
        # passport = models.CharField('Member passport', max_length=64, null=True, blank=True)
        # gender = models.CharField('Member gender', max_length=64, null=True, blank=True)
        # nationality = models.CharField('Member nationality', max_length=64, null=True, blank=True)
        # block = models.CharField('Member block', max_length=64, null=True, blank=True)
        # level = models.CharField('Member level', max_length=64, null=True, blank=True)
        # unit = models.CharField('Member unit', max_length=64, null=True, blank=True)
        # street = models.CharField('Member street', max_length=64, null=True, blank=True)
        # building = models.CharField('Member building', max_length=64, null=True, blank=True)
        # postal_code = models.CharField('Member postal_code', max_length=64, null=True, blank=True)
        # country = models.CharField('Member country', max_length=64, null=True, blank=True)
        # address1 = models.CharField('Member address1', max_length=64, null=True, blank=True)
        # address2 = models.CharField('Member address2', max_length=64, null=True, blank=True)
        # address3 = models.CharField('Member address3', max_length=64, null=True, blank=True)
        # contact_no = models.CharField('contact_no', max_length=64, null=True, blank=True)
        # fax_no = models.CharField('fax_no', max_length=64, null=True, blank=True)
        # referrer_code = models.CharField('referrer_code', max_length=64, null=True, blank=True)
        # facebook_id = models.CharField('salutation', max_length=64, null=True, blank=True)
        # facebook_name = models.CharField('facebook_name', max_length=64, null=True, blank=True)
        # facebook_photo_link = models.CharField('facebook_photo_link', max_length=128, null=True, blank=True)
        # facebook_token = models.CharField('facebook_token', max_length=128, null=True, blank=True)
        # facebook_token_expiry = models.CharField('facebook_token_expiry', max_length=64, null=True, blank=True)
        # full_photo_name = models.CharField('full_photo_name', max_length=64, null=True, blank=True)
        # base64_photo_string = models.CharField('base64_photo_string', max_length=256, null=True, blank=True)
        # photo_link = models.CharField('photo_link', max_length=128, null=True, blank=True)
        # race_code = models.CharField('race_code', max_length=64, null=True, blank=True)
        # notify_post = models.NullBooleanField('notify_post', max_length=64, null=True, blank=True)
        # notify_sms = models.NullBooleanField('notify_sms', max_length=64, null=True, blank=True)
        # first_name = models.CharField('first_name', max_length=64, null=True, blank=True)
        # last_name = models.CharField('last_name', max_length=64, null=True, blank=True)


class Membership_Member(models.Model):
    member = models.ForeignKey(to='Member', related_name='membership_members',
                               on_delete=models.CASCADE)
    membership = models.ForeignKey(to='Membership', related_name='membership_members',
                                   on_delete=models.CASCADE)
    effective_date = models.DateTimeField('effective_date', default=timezone.now)
    expiring_date = models.DateTimeField('expiring_date', default=one_year_later)
    ACTIVE, EXPIRED = range(2)
    STATUS_CHOICES = (
        (ACTIVE, 'active'),
        (EXPIRED, 'expired'),
    )
    status = models.PositiveSmallIntegerField(
        "status",
        choices=STATUS_CHOICES,
        help_text="0:active,1:expired",
    )


class Card(models.Model):
    card_no = models.CharField(' Member card number Member', max_length=64, unique=True)
    member = models.ForeignKey(to='Member', related_name='cards', on_delete=models.CASCADE, null=True, blank=True)
    printed_name = models.CharField('The name of the member card', max_length=64, null=True, blank=True)
    membership_type_code = models.CharField('Member type code', max_length=64, null=True, blank=True)
    membership_status_code = models.CharField('Member status code', max_length=64, null=True, blank=True)
    membership_photo = models.CharField('Member photo', max_length=64, null=True, blank=True)
    issue_date = models.DateTimeField('Issue date', null=True, blank=True)
    effective_date = models.DateTimeField('Effective Date', null=True, blank=True)
    expiry_date = models.DateTimeField('Expiry Date ', null=True, blank=True)
    printed = models.NullBooleanField('printed', null=True, blank=True)
    printed_date = models.DateTimeField('Printed Date', null=True, blank=True)
    renewed_date = models.DateTimeField('Renewed Date', null=True, blank=True)
    tmp_effective_date = models.DateTimeField('Tmp Effective Date', null=True, blank=True)
    tmp_expiry_date = models.DateTimeField('Tmp Expiry Date', null=True, blank=True)
    tmp_membership_status_code = models.CharField('Tmp Membership Status Code', max_length=64, null=True, blank=True)
    points_bal = models.FloatField('Points Bal', max_length=32, null=True, blank=True, default=0)
    total_points_bal = models.FloatField('Total_Points Bal', max_length=32, null=True, blank=True, default=0)
    holding_points = models.FloatField('Holding Points', max_length=32, null=True, blank=True, default=0)
    remarks = models.CharField('Remarks', max_length=64, null=True, blank=True)
    membership_discount = models.FloatField('Membership Discount', max_length=32, null=True, blank=True, default=0)
    tier_code = models.CharField('Tier Code', max_length=64, null=True, blank=True)
    tier_anniversary_start_date = models.DateTimeField('Tier Anniversary Start Date', null=True, blank=True)
    tier_anniversary_end_date = models.DateTimeField('Tier Anniversary End Date', null=True, blank=True)
    loyalty_message = models.CharField('Loyalty Message', max_length=64, null=True, blank=True)
    dollar_to_points_ratio = models.FloatField('Dollar to Point Ratio', max_length=32, null=True, blank=True, default=0)
    is_supplementary = models.NullBooleanField('Is Supplementary', null=True, blank=True)
    is_burn_supplementary = models.NullBooleanField('Is Burn Supplementary', null=True, blank=True)
    relation_id = models.CharField('Relation Id', max_length=64, null=True, blank=True)
    primary_card_no = models.CharField('Primary Card No', max_length=64, null=True, blank=True)
    primary_relation_id = models.CharField('Primary Relation Id', max_length=64, null=True, blank=True)
    primary_card_expiry_date = models.DateTimeField('Primary Card Expiry Date ', null=True, blank=True)
    primary_card_effective_date = models.DateTimeField('Primary Card Effective Date', null=True, blank=True)
    pts_holding_days = models.IntegerField('Pts Holding Days', null=True, blank=True)
    current_net_spent = models.FloatField('Current Net Spent', max_length=32, null=True, blank=True, default=0)
    pass_code = models.CharField('Pass Code', max_length=64, null=True, blank=True)
    stored_value_balance = models.FloatField('Stored Value Balance', max_length=32, null=True, blank=True, default=0)
    currency = models.CharField('Currency', max_length=64, null=True, blank=True)
    last_visited_date = models.DateTimeField('Last Visited Date', null=True, blank=True)
    last_visited_outlet = models.CharField('Last Visited Outlet', max_length=64, null=True, blank=True)
    points_to_next_tier = models.FloatField('Points To Next Tier', max_length=32, null=True, blank=True, default=0)
    nett_to_next_tier = models.FloatField('Nett To Next Tier', max_length=32, null=True, blank=True, default=0)
    lucky_draw_conversion_pts_usage_type = models.CharField(max_length=64, null=True, blank=True)
    lucky_draw_conversion_rate = models.CharField('Lucky Draw Conversion Rate', max_length=64, null=True, blank=True)
    spent_quota_increasement = models.FloatField(max_length=32, null=True, blank=True, default=0)
    spent_quota_increasement_expired_on = models.CharField(max_length=64, null=True, blank=True)
    pickup_date = models.DateTimeField('pickup_date', null=True, blank=True)
    pickup_by = models.CharField('pickup_by', max_length=64, null=True, blank=True)
    current_rcnett_spent = models.IntegerField('current_rcnett_spent', null=True, blank=True)
    cmc_earned_points = models.FloatField('cmc_earned_points', max_length=32, null=True, blank=True, default=0)
    crc_earned_points = models.IntegerField('crc_earned_points', null=True, blank=True)
    current_tier_nett = models.FloatField('current_tier_nett', max_length=32, null=True, blank=True, default=0)
    current_tier_amt = models.FloatField('current_tier_amt', max_length=32, null=True, blank=True, default=0)
    bring_fwd_tier_nett = models.FloatField('bring_fwd_tier_nett', max_length=32, null=True, blank=True, default=0)
    bring_fwd_tier_amt = models.FloatField('bring_fwd_tier_amt', max_length=32, null=True, blank=True, default=0)
    bring_fwd_tier_expiry = models.CharField('bring_fwd_tier_expiry', max_length=64, null=True, blank=True)
    bring_fwd_tier_start_date = models.DateTimeField('bring_fwd_tier_start_date', null=True, blank=True)
    extended_tier_anniversary_end_date = models.DateTimeField(null=True, blank=True)


class Occupation(models.Model):
    name = models.CharField('Occupation name', max_length=32, unique=True)


class CampaignCondition(models.Model):
    campaign = models.ForeignKey(to='Campaign', related_name='campaignconditions',
                                 on_delete=models.CASCADE)
    every_spent = models.FloatField('every_spent', null=True, blank=True)
    every_top_up = models.FloatField('every_top_up', null=True, blank=True)
    every_use_points = models.FloatField('every_use_points', null=True, blank=True)
    every_purchase_points = models.FloatField('every_purchase_points', null=True, blank=True)
    every_purchase_m_drinks_flavors = models.ManyToManyField(to='Product', related_name='m_drinks_condition', null=True,
                                                             blank=True)
    every_purchase_l_drinks_flavors = models.ManyToManyField(to='Product', related_name='l_drinks_condition', null=True,
                                                             blank=True)
    every_purchase_products = models.ManyToManyField(to='Product',
                                                     related_name='products_condition', null=True, blank=True)
    A, B, C, D, E, F = range(6)
    ACTIONS_CHOICES = (
        (A, 'Like our facebook page itea.sg'),
        (B, 'Like our facebook post'),
        (C, 'Rate us on facebook'),
        (D, 'Post on our facebook page'),
        (E, 'Share our facebook page/post'),
        (F, 'Like our instagram'),
    )
    online_actions = ArrayField(models.PositiveSmallIntegerField(
        choices=ACTIONS_CHOICES,
    ), verbose_name='online_actions', null=True, blank=True)
    every_customers = models.IntegerField('every_customers', null=True, blank=True)
    A, B, C, D, E, F, G, H, I, J, K = range(11)
    ORDERING_MODE_CHOICES = (
        (A, 'cash'),
        (B, 'apple pay'),
        (C, 'andriod pay'),
        (D, 'visa'),
        (E, 'mastercard'),
        (F, 'ezylink'),
        (G, 'QR code'),
        (H, 'favepay'),
        (I, 'grabpay'),
        (J, 'Alipay'),
        (K, 'Internet Banking'),
    )
    ordering_modes = ArrayField(models.PositiveSmallIntegerField(
        choices=ORDERING_MODE_CHOICES,
    ), verbose_name='ordering_modes', null=True, blank=True)
    WALKIN, MOBILE = range(2)
    PAYMENT_MODE_CHOICES = (
        (WALKIN, 'Walk-in'),
        (MOBILE, 'Mobile ordering'),
    )
    payment_modes = ArrayField(models.PositiveSmallIntegerField(
        choices=PAYMENT_MODE_CHOICES,
    ), verbose_name='payment_modes', null=True, blank=True)
    other_actions = models.TextField('other_actions', null=True, blank=True)
    limit_redemption = models.IntegerField('limit_redemption', null=True, blank=True)


class Campaign(models.Model):
    name = models.CharField('Campaign name', max_length=128)
    description = models.CharField('Campaign description', max_length=128, null=True, blank=True)
    occupations = models.ManyToManyField(to='Occupation', related_name='campaigns',
                                         null=True, blank=True)
    memberships = models.ManyToManyField(to='Membership', related_name='campaigns',
                                         null=True, blank=True)
    M, F = range(2)
    GENDER_CHOICES = (
        (M, 'Male'),
        (F, 'Female'),
    )
    gender = ArrayField(models.PositiveSmallIntegerField(choices=GENDER_CHOICES), verbose_name='gender',
                        help_text="0:Male,1:Female", null=True, blank=True)
    # min_age = models.IntegerField('min_age', null=True, blank=True)
    # max_age = models.IntegerField('max_age', null=True, blank=True)
    age = ArrayField(models.CharField(max_length=128), verbose_name='age', null=True, blank=True)
    A, B, C, D, E, F, G, H, I = range(9)
    Repetition_periods_CHOICES = (
        (A, 'daily'),
        (B, 'every mon'),
        (C, 'every tue'),
        (D, 'every wed'),
        (E, 'every thur'),
        (F, 'every fri'),
        (G, 'every sat'),
        (H, 'every sun'),
        (I, 'monthly'),
    )
    repetition_periods = ArrayField(models.PositiveSmallIntegerField(
        choices=Repetition_periods_CHOICES,
    ), verbose_name='repetition_periods', null=True, blank=True)
    DAYS_CHOICES = []
    for i in range(31):
        DAYS_CHOICES.append((i + 1, i + 1))
    days_of_month = ArrayField(models.PositiveSmallIntegerField(
        choices=DAYS_CHOICES,
    ), verbose_name='days_of_month', null=True, blank=True)
    effective_date = models.DateField('Campaign effective Date')
    expiring_date = models.DateField('Campaign Expiring Date')
    every_1_dollar_bouns_points = models.FloatField('every_1_dollar_bouns_points', null=True, blank=True)
    outlets = models.ManyToManyField(to='Outlet', related_name='campaigns', null=True, blank=True)
    event_venue = models.CharField('event_venue', max_length=64, null=True, blank=True)
    processing, waiting, launched, completed, archived = range(5)
    STATE_CHOICES = (
        (processing, 'processing'),
        (waiting, 'waiting'),
        (launched, 'launched'),
        (completed, 'completed'),
        (archived, 'archived'),
    )
    state = models.PositiveSmallIntegerField(
        "Campaign state",
        choices=STATE_CHOICES,
        help_text="0:processing,1:waiting,2:launched,3:completed,4:archived",
    )


class CampaignType(models.Model):
    campaign = models.ForeignKey(to='Campaign', related_name='campaigntypes',
                                 on_delete=models.CASCADE)
    first_discount_per = models.FloatField('first_discount_per', null=True, blank=True)
    last_discount_per = models.FloatField('last_discount_per', null=True, blank=True)
    first_discount_price = models.FloatField('first_discount_price', null=True, blank=True)
    last_discount_price = models.FloatField('last_discount_price', null=True, blank=True)
    bouns_points = models.FloatField('Reward points', null=True, blank=True)
    top_up_money = models.FloatField('top_up_money', null=True, blank=True)
    upgrade_membership = models.ForeignKey(to='Membership',
                                           on_delete=models.CASCADE, null=True, blank=True)
    free_vouchers = models.ManyToManyField(to='Voucher', related_name='campaigns',
                                           null=True, blank=True)
    campaign_condition = models.OneToOneField(to='CampaignCondition', related_name='campaigntype',
                                              on_delete=models.CASCADE)


class Outlet(models.Model):
    outlet_name = models.CharField('Outlet name', max_length=64, unique=True)
    outlet_code = models.CharField('Outlet code', max_length=64, unique=True)
    outlet_manager = models.CharField('outlet_manager', max_length=64)
    outlet_district = models.CharField('outlet_district', max_length=64)
    outlet_floor_area = models.FloatField('outlet_floor_area')
    outlet_address = models.CharField('outlet_address', max_length=64)


class Category(models.Model):
    name = models.CharField('Product category name', max_length=32)
    category_code = models.CharField('category_code', max_length=64, unique=True)
    description = models.CharField('description', max_length=128, null=True, blank=True)


class Product(models.Model):
    name = models.CharField('Product name', max_length=32, unique=True)
    description = models.CharField('description', max_length=128, null=True, blank=True)
    price = models.FloatField('Product price')
    tea_base = models.CharField('Product tea_base', max_length=32, null=True, blank=True)
    item_code = models.CharField('Product item_code', max_length=64, unique=True)
    category = models.ForeignKey(to='Category', related_name='products',
                                 on_delete=models.CASCADE)
    created = models.DateTimeField('Product created time', default=one_year_later)
    MEDIUM, LARGE = range(2)
    SIZE_CHOICES = (
        (MEDIUM, 'Meduim'),
        (LARGE, 'Large'),
    )
    size = models.IntegerField("size", choices=SIZE_CHOICES, help_text="0:Meduim,1:Large")


class Toppings(models.Model):
    name = models.CharField('Toppings name', max_length=32, unique=True)
    description = models.CharField('description', max_length=128, null=True, blank=True)
    price = models.FloatField('Toppings price')


class Voucher(models.Model):
    #
    name = models.CharField('Voucher name', max_length=128)
    Product, Upgrade, Cash, Discount, BuyOneGetOne, Toppings = range(6)
    TYPE_CHOICES = (
        (Product, 'Product'),
        (Upgrade, 'Size upgrade'),
        (Cash, 'Cash'),
        (Discount, 'Discount'),
        (BuyOneGetOne, 'Buy one get one free'),
        (Toppings, 'Toppings'),
    )
    type = models.PositiveSmallIntegerField('type', choices=TYPE_CHOICES,
                                            help_text='0:Product,1:Size upgrade,2:Cash,3:Discount,4:Buy one get one free,5:Toppings')
    description = models.CharField('Voucher description', max_length=128, null=True, blank=True)
    voucher_code = models.CharField('voucher_code', max_length=32, unique=True)
    effective_date = models.DateField('effective Date')
    expiring_date = models.DateField('expiring_date')
    redemption_points = models.FloatField('redemption_points')
    redemption_toppings = models.ManyToManyField(to='Toppings', related_name='vouchers', null=True, blank=True)
    toppings_number = models.IntegerField('toppings_number', null=True, blank=True)
    redemption_products = models.ManyToManyField(to='Product', related_name='vouchers_redemption', null=True,
                                                 blank=True)
    M, L = range(2)
    SIZE_CHOICES = (
        (M, 'medium'),
        (L, 'large'),
    )
    product_size = ArrayField(models.PositiveSmallIntegerField(
        choices=SIZE_CHOICES,
    ), verbose_name='product_size', help_text="0:medium,1:large", null=True, blank=True)
    product_number = models.IntegerField('product_number', null=True, blank=True)
    # size_upgrade_unparticipated_products = models.ManyToManyField(to='Product', related_name='vouchers_upgrade',
    #                                                               null=True, blank=True)
    size_upgrade = models.BooleanField('size_upgrade', default=False)
    # discount_per_unparticipated_products = models.ManyToManyField(to='Product', related_name='vouchers_discount_per',
    #                                                               null=True, blank=True)
    discount_percent = models.FloatField('discount_percent', null=True, blank=True)
    # discount_price_unparticipated_products = models.ManyToManyField(to='Product',
    #                                                                 related_name='vouchers_discount_price', null=True,
    #                                                                 blank=True)
    discount_price = models.FloatField('discount_price', null=True, blank=True)
    number_purchase = models.IntegerField('number_purchase', null=True, blank=True)
    number_complimentary_drinks = models.IntegerField('number_complimentary_drinks', null=True, blank=True)
    processing, waiting, launched, completed, archived = range(5)
    STATE_CHOICES = (
        (processing, 'processing'),
        (waiting, 'waiting'),
        (launched, 'launched'),
        (completed, 'completed'),
        (archived, 'archived'),
    )
    state = models.PositiveSmallIntegerField(
        "state",
        choices=STATE_CHOICES,
        help_text="0:processing,1:waiting,2:launched,3:completed,4:archived",
    )
    unparticipated_outlets = models.ManyToManyField(to='Outlet', related_name='vouchers', null=True, blank=True)
    limit_memberships = models.ManyToManyField(to='Membership',
                                               related_name='vouchers', null=True, blank=True)
    exclusive_new_members = models.BooleanField('exclusive_new_members', default=False)
    exclusive_non_members = models.BooleanField('exclusive_non_members', default=False)
    redemption_per = models.IntegerField('redemption_per', null=True, blank=True)
    limit_first_redemption = models.IntegerField('limit_first_redemption', null=True, blank=True)
    A, B, C, D, E, F, G, H = range(8)
    OTHER_LIMITS_CHOICES = (
        (A, 'Not valid with other promo'),
        (B, 'Non- refundable, non-transferable, non-reusable and non-exchangable for cash/points/credit in kind'),
        (C, 'Voucher(s) must be used upon payment'),
        (D, 'Voucher(s) must be utilized fully to the amount stated. Any unused amount will not be refunded'),
        (E, 'Purchase exxceeding redemption value shall be topped up with cash or other payment option'),
        (F, 'itea reserves the right to amend the terms and conditions without prior notice'),
        (G, 'Redemption must be shown upon ordering for counter ordering'),
        (H, 'itea will not be responsible for replacing expired vouchers'),
    )
    other_limits = ArrayField(models.PositiveSmallIntegerField(
        choices=OTHER_LIMITS_CHOICES,
    ), verbose_name='other_limits', null=True, blank=True)


class Voucher_Member(models.Model):
    voucher = models.ForeignKey(to='Voucher', related_name='voucher_members',
                                on_delete=models.CASCADE)
    member = models.ForeignKey(to='Member', related_name='voucher_members',
                               on_delete=models.CASCADE)
    A, B, C = range(3)
    STATUS_CHOICES = (
        (A, 'active'),
        (B, 'used'),
        (C, 'expired'),
    )
    status = models.PositiveSmallIntegerField(
        "Voucher status",
        choices=STATUS_CHOICES,
        help_text="0:active,1:used,2:expired",
        default=A
    )
    created = models.DateTimeField('created', default=timezone.now)


class Points_Member(models.Model):
    member = models.ForeignKey(to='Member', related_name='points', on_delete=models.CASCADE)
    points_number = models.FloatField('points_number')
    A, B, C, D = range(4)
    METHOD_CHOICES = (
        (A, 'Complete information'),
        (B, 'Binding email'),
        (C, 'Campaign reward points'),
        (D, 'Redeem vouchers'),
    )
    method = models.PositiveSmallIntegerField(
        "method",
        choices=METHOD_CHOICES,
        help_text="0:Complete information,1:Binding email,2:Campaign reward points",
    )
    campaigntype = models.ForeignKey(to='CampaignType', on_delete=models.CASCADE, null=True, blank=True)
    created = models.DateTimeField('created', default=timezone.now)


class Transaction(models.Model):
    member = models.ForeignKey(to='Member', related_name='transaction', on_delete=models.CASCADE, null=True, blank=True)
    outlet = models.ForeignKey(to='Outlet', related_name='transaction', on_delete=models.CASCADE)
    campaigns = models.ManyToManyField(to='Campaign', related_name='transactions', null=True, blank=True)
    campaigntypes = models.ManyToManyField(to='CampaignType', related_name='transactions', null=True, blank=True)
    reward_vouchers = models.ManyToManyField(to='Voucher', related_name='transaction_reward', null=True, blank=True)
    redeemed_vouchers = models.ManyToManyField(to='Voucher', related_name='transaction_redeemed', null=True, blank=True)
    reward_points = models.FloatField('reward_points', null=True, blank=True)
    redeemed_points = models.FloatField('redeemed_points', null=True, blank=True)
    A, B, C, D, E, F, G, H, I, J, K = range(11)
    ORDERING_MODE_CHOICES = (
        (A, 'cash'),
        (B, 'apple pay'),
        (C, 'andriod pay'),
        (D, 'visa'),
        (E, 'mastercard'),
        (F, 'ezylink'),
        (G, 'QR code'),
        (H, 'favepay'),
        (I, 'grabpay'),
        (J, 'Alipay'),
        (K, 'Internet Banking'),
    )
    ordering_modes = models.PositiveSmallIntegerField('ordering_modes', choices=ORDERING_MODE_CHOICES)
    WALKIN, MOBILE = range(2)
    PAYMENT_MODE_CHOICES = (
        (WALKIN, 'Walk-in'),
        (MOBILE, 'Mobile ordering'),
    )
    payment_modes = models.PositiveSmallIntegerField('payment_modes', choices=PAYMENT_MODE_CHOICES)
    pos_no = models.CharField('pos_no', max_length=32, null=True, blank=True)
    cashier_no = models.CharField('cashier_no', max_length=32, null=True, blank=True)
    receipt_no = models.CharField('receipt_no', max_length=32)
    transact_datetime = models.DateTimeField('transact_datetime', default=timezone.now)
    total_money = models.FloatField('total_money')
    remark = models.CharField('remark', max_length=64, null=True, blank=True)
    # transact_type = models.CharField('transact_type', max_length=32, null=True, blank=True)
    # is_rebate_system = models.NullBooleanField('is_rebate_system', null=True, blank=True)
    # rebate_usage = models.IntegerField('rebate_usage', default=2)
    # A, B = range(1, 3)
    # TYPE_CHOICES = (
    #     (A, 'Earn points for shopping'),
    #     (B, 'Use points to redeem voucher')
    # )
    # points_calculation_type = models.PositiveSmallIntegerField(
    #     "points_calculation_type",
    #     choices=TYPE_CHOICES,
    #     help_text="1:Earn points for shopping,2:Use points to redeem voucher",
    #     default=A
    # )
    # points_usage = models.CharField('points_usage', max_length=32, default='COMBINE')
    # redeemed_item_code = models.CharField('redeemed_item_code', max_length=32, null=True, blank=True)
    # rebate_to_be_reducted = models.FloatField('rebate_to_be_reducted', null=True, blank=True)


class TransactDetails(models.Model):
    transaction = models.ForeignKey(to='Transaction', related_name='transact_details', on_delete=models.CASCADE)
    product = models.ForeignKey(to='Product', related_name='transact_details', on_delete=models.CASCADE)
    toppings = models.ForeignKey(to='Toppings', related_name='transact_details', on_delete=models.CASCADE, null=True,
                                 blank=True)
    remark = models.CharField('remark', max_length=128, null=True, blank=True)
    quantity = models.IntegerField('quantity')
    price = models.FloatField('price')
    eat_in, take_out = range(2)
    METHOD_CHOICES = (
        (eat_in, 'eat in'),
        (take_out, 'take out'),
    )
    method = models.IntegerField("method", choices=METHOD_CHOICES, help_text="0:eat in,1:take out")
    LESS, MORE = range(2)
    SWEETNAEE_CHOICES = (
        (LESS, 'less'),
        (MORE, 'more'),
    )
    sweetness = models.IntegerField("sweetness", choices=SWEETNAEE_CHOICES, help_text="0:less,1:more", null=True,
                                    blank=True)

    NORMAL, LESS_ICE, NO_ICE = range(3)
    ICE_LEVEL_CHOICES = (
        (NORMAL, 'Normal'),
        (LESS_ICE, 'Less Ice'),
        (NO_ICE, 'No Ice'),
    )
    ice_level = models.IntegerField("ice_level", choices=ICE_LEVEL_CHOICES, help_text="0:normal,1:less ice,2:no ice",
                                    null=True, blank=True)
    ZERO, TWRNTY_FIVE, FIFTY, SEVENTY_FIVE, ONE_HUNDRED = range(5)
    SUGAR_LEVEL_CHOICES = (
        (ZERO, "0%"),
        (TWRNTY_FIVE, "25%"),
        (FIFTY, "50%"),
        (SEVENTY_FIVE, "75%"),
        (ONE_HUNDRED, "100%"),
    )
    sugar_level = models.IntegerField("sugar_level", choices=SUGAR_LEVEL_CHOICES,
                                      help_text="0:0%,1:25%,2:50%,3:75%,4:100%", null=True, blank=True)
    ZERO, TWRNTY_FIVE, FIFTY, SEVENTY_FIVE, ONE_HUNDRED = range(5)
    CONCENTRATION_CHOICES = (
        (ZERO, "0%"),
        (TWRNTY_FIVE, "25%"),
        (FIFTY, "50%"),
        (SEVENTY_FIVE, "75%"),
        (ONE_HUNDRED, "100%"),
    )
    concentration = models.IntegerField("concentration", choices=CONCENTRATION_CHOICES,
                                        help_text="0:0%,1:25%,2:50%,3:75%,4:100%", null=True, blank=True)


class Wallet(models.Model):
    balance = models.FloatField('balance', default=0)
    created = models.DateTimeField('created', auto_now_add=True)
    lastest_top_up = models.DateField('lastest_top_up', null=True, blank=True)
    member = models.OneToOneField(to='Member', related_name='wallet', on_delete=models.CASCADE)


class RechargeRecord(models.Model):
    money = models.FloatField('money')
    created = models.DateTimeField('created', auto_now_add=True)
    wallet = models.ForeignKey(to='Wallet', related_name='rechargerecord',
                               on_delete=models.CASCADE)
    TYPE_CHOICES = (
        (0, "recharge"),
        (1, "deduction")
    )
    type = models.IntegerField(default="0", null=False, choices=TYPE_CHOICES)


class Evaluation(models.Model):
    service_content = models.CharField('service_content', max_length=128, null=True, blank=True)
    A, B, C, D, E, F, G, H, I, J = range(10)
    SCORE_CHOICES = (
        (A, 1),
        (B, 2),
        (C, 3),
        (D, 4),
        (E, 5),
        (F, 6),
        (G, 7),
        (H, 8),
        (I, 9),
        (J, 10),
    )
    service_satisfaction = models.PositiveSmallIntegerField('service_satisfaction', choices=SCORE_CHOICES)
    product_quality_content = models.CharField('product_quality_content', max_length=128, null=True, blank=True)
    product_quality_satisfaction = models.PositiveSmallIntegerField('product_quality_satisfaction',
                                                                    choices=SCORE_CHOICES)
    created = models.DateTimeField('created', auto_now_add=True)
    transaction = models.ForeignKey(to='Transaction', related_name='evaluation',
                                    on_delete=models.CASCADE)


class Cart(models.Model):
    product = models.ForeignKey(to='Product', related_name='cart', on_delete=models.CASCADE)
    member = models.ForeignKey(to='Member', related_name='cart', on_delete=models.CASCADE)
    quantity = models.IntegerField('quantity')
    price = models.FloatField('price')
    created = models.DateTimeField('created', auto_now_add=True)
    updated = models.DateTimeField('updated', auto_now=True)
    A, B, C, D = range(4)
    STATUS_CHOICES = (
        (A, 'active'),
        (B, 'bought'),
        (C, 'deleted'),
        (D, 'invalid'),
    )
    status = models.IntegerField(
        "status",
        choices=STATUS_CHOICES,
        help_text="0:active,1:bought,2:deleted,3:invalid",
        default=A
    )
    flavours = models.CharField('flavours', max_length=32, null=True, blank=True)
    FRUIT_TEA, PREMUM_TEA, MILK_TEA = range(3)
    TEA_BASE_CHOICES = (
        (FRUIT_TEA, 'FRUIT TEA'),
        (PREMUM_TEA, 'PREMUM TEA'),
        (MILK_TEA, 'MILK TEA'),
    )
    tea_base = models.IntegerField(
        "tea_base",
        choices=TEA_BASE_CHOICES,
        help_text="0:FRUIT TEA,1:PREMUM TEA,2:MILK TEA",
        null=True,
        blank=True
    )
    LESS, MORE = range(2)
    SWEETNAEE_CHOICES = (
        (LESS, 'less'),
        (MORE, 'more'),
    )
    sweetness = models.IntegerField(
        "sweetness",
        choices=SWEETNAEE_CHOICES,
        help_text="0:less,1:more",
        null=True, blank=True)
    MEDIUM, LARGE = range(2)
    SIZE_CHOICES = (
        (MEDIUM, 'Meduim'),
        (LARGE, 'Large'),
    )
    size = models.IntegerField(
        "size",
        choices=SIZE_CHOICES,
        help_text="0:Meduim,1:Large",
        null=True, blank=True)
    No_Pearls, AiYu_Jelly, Golden_Bubbles, Oreo, White_Jelly, Whipped_Cream = range(6)
    toppings_choices = (
        (No_Pearls, "No Pearls"),
        (AiYu_Jelly, "AiYu Jelly"),
        (Golden_Bubbles, "Golden Bubbles"),
        (Oreo, "Oreo"),
        (White_Jelly, "White Jelly"),
        (Whipped_Cream, "Whipped Cream"),
    )
    toppings = models.IntegerField(
        "toppings",
        choices=toppings_choices,
        help_text="0:No Pearls,1:AiYu Jelly,2:Golden Bubbles,3:Oreo,4:White Jelly,5:Whipped Cream",
        null=True, blank=True)
    NORMAL, LESS_ICE, NO_ICE = range(3)
    ICE_LEVEL_CHOICES = (
        (NORMAL, 'Normal'),
        (LESS_ICE, 'Less Ice'),
        (NO_ICE, 'No Ice'),
    )
    ice_level = models.IntegerField(
        "ice_level",
        choices=ICE_LEVEL_CHOICES,
        help_text="0:normal,1:less ice,2:no ice",
        default=1,
        null=True,
        blank=True
    )
    ZERO, TWRNTY_FIVE, FIFTY, SEVENTY_FIVE, ONE_HUNDRED = range(5)
    SUGAR_LEVEL_CHOICES = (
        (ZERO, "0%"),
        (TWRNTY_FIVE, "25%"),
        (FIFTY, "50%"),
        (SEVENTY_FIVE, "75%"),
        (ONE_HUNDRED, "100%"),
    )
    sugar_level = models.IntegerField(
        "sugar_level",
        choices=SUGAR_LEVEL_CHOICES,
        help_text="0:0%,1:25%,2:50%,3:75%,4:100%",
        default=1,
        null=True, blank=True)
    ZERO, TWRNTY_FIVE, FIFTY, SEVENTY_FIVE, ONE_HUNDRED = range(5)
    CONCENTRATION_CHOICES = (
        (ZERO, "0%"),
        (TWRNTY_FIVE, "25%"),
        (FIFTY, "50%"),
        (SEVENTY_FIVE, "75%"),
        (ONE_HUNDRED, "100%"),
    )
    concentration = models.IntegerField(
        "concentration",
        choices=CONCENTRATION_CHOICES,
        help_text="0:0%,1:25%,2:50%,3:75%,4:100%",
        default=1,
        null=True,
        blank=True
    )
    is_new = models.BooleanField('is_new', default=False)


class Token(authToken):
    pass
