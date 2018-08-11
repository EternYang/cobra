from rest_framework import serializers
from app01 import models
from utils.utils import except_validation_error
from outlet.service import get_or_create_outlet
from product.service import get_or_create_product, get_or_create_toppings
from campaign.service import insert_member_campaigntype
from voucher.service import record_reward_member_voucher, record_redeemed_member_voucher
from member.services import update_points, update_member_last_purchase_date


class TransactionRSerializer(serializers.ModelSerializer):
    class TransactDetailsSerializer(serializers.ModelSerializer):
        class Meta:
            model = models.TransactDetails
            exclude = ('transaction',)
            depth = 2

    transact_details = TransactDetailsSerializer(many=True, read_only=True)
    member = serializers.PrimaryKeyRelatedField(queryset=models.Member.objects.all())
    campaigns = serializers.PrimaryKeyRelatedField(queryset=models.Campaign.objects.all(), many=True)
    campaigntypes = serializers.PrimaryKeyRelatedField(queryset=models.CampaignType.objects.all(), many=True)
    reward_vouchers = serializers.PrimaryKeyRelatedField(queryset=models.Voucher.objects.all(), many=True)
    redeemed_vouchers = serializers.PrimaryKeyRelatedField(queryset=models.Voucher.objects.all(), many=True)

    class Meta:
        model = models.Transaction
        fields = '__all__'
        depth = 2


class TransactionCSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Transaction
        exclude = ('outlet',)

    @except_validation_error
    def create(self, validated_data):
        # Insert the outlet information in the transaction record
        outlet = get_or_create_outlet(self.initial_data.get('outlet'))
        validated_data['outlet'] = outlet
        instance = super(TransactionCSerializer, self).create(validated_data)
        # Insert the campaign type record that the member has participated in
        insert_member_campaigntype(instance.member, instance.campaigntypes.all())
        # Record the voucher obtained by this member
        record_reward_member_voucher(instance.member, instance.reward_vouchers.all())
        # Record the voucher redeemed by this member
        record_redeemed_member_voucher(instance.member, instance.redeemed_vouchers.all())
        # Record the points earned and redeemed by this member
        for count, campaign_type in enumerate(instance.campaigntypes.all()):
            if count == 0:
                update_points(instance.member, instance.reward_points, 2, campaigntype=campaign_type)
                update_points(instance.member, -instance.redeemed_points, 3, campaigntype=campaign_type)
            else:
                update_points(instance.member, 0, 2, campaigntype=campaign_type)
                update_points(instance.member, -0, 3, campaigntype=campaign_type)
        # update member last_purchase_date
        update_member_last_purchase_date(instance.member, instance.transact_datetime)
        return instance


class TransactDetailsRSerializer(serializers.ModelSerializer):
    class TransactionSerializer1(serializers.ModelSerializer):
        class Meta:
            model = models.Transaction
            fields = ('receipt_no', 'transact_datetime', 'member')

    transaction = TransactionSerializer1(read_only=True)

    class Meta:
        model = models.TransactDetails
        fields = '__all__'
        # exclude = ('transaction',)
        depth = 2


class SalesRecordSerializer(serializers.ModelSerializer):
    amount = serializers.FloatField(required=False, allow_null=True)
    category_name = serializers.CharField(required=False, allow_null=True)

    class Meta:
        model = models.Product
        fields = "__all__"


class TransactDetailsCSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.TransactDetails
        exclude = ('product', 'toppings')

    @except_validation_error
    def create(self, validated_data):
        # Insert the product information in the transaction details
        product = get_or_create_product(self.initial_data.get('product'))
        validated_data['product'] = product
        # Insert the toppings information in the transaction details
        toppings = get_or_create_toppings(self.initial_data.get('toppings'))
        validated_data['toppings'] = toppings
        instance = super(TransactDetailsCSerializer, self).create(validated_data)
        return instance


class EvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Evaluation
        fields = '__all__'
