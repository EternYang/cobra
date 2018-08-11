from rest_framework import serializers
from app01 import models


class OccupationSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Occupation
        fields = '__all__'


class CampaignTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CampaignType
        fields = '__all__'


class CampaignConditionSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CampaignCondition
        fields = '__all__'


class CampaignCUDSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Campaign
        fields = '__all__'


class CampaignRSerializer(serializers.ModelSerializer):
    class CampaignTypeSerializer(serializers.ModelSerializer):
        campaign_condition = CampaignConditionSerializer()

        class Meta:
            model = models.CampaignType
            exclude = ('campaign',)
            # fields = ('id', 'campaign_condition',)

    campaigntypes = CampaignTypeSerializer(many=True, read_only=True)
    # sum_money = serializers.FloatField(required=False, allow_null=True)
    turnover = serializers.FloatField(required=False, allow_null=True)
    # sum_quantity = serializers.FloatField(required=False, allow_null=True)
    products_sold = serializers.FloatField(required=False, allow_null=True)
    transactions_count = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Campaign
        fields = '__all__'

    # def to_representation(self, instance):
    #     ret = super(CampaignRSerializer, self).to_representation(instance)
    #     transaction_count = instance.transactions.count()
    #     ret['transactions'] = transaction_count
    #     return ret
