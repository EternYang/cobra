from rest_framework import serializers
from app01 import models
from utils.utils import except_validation_error
from .service import recharge


class WalletSerializer(serializers.ModelSerializer):
    class MemberSerializer(serializers.ModelSerializer):
        class Meta:
            model = models.Member
            fields = ('id', 'name')

    member = MemberSerializer()
    total_consumption = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Wallet
        fields = '__all__'


class RechargeRecordListSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.RechargeRecord
        fields = '__all__'


class RechargeRecordCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.RechargeRecord
        fields = '__all__'

    @except_validation_error
    def create(self, validated_data):
        # create RechargeRecord instance
        instance = super(RechargeRecordCreateSerializer, self).create(validated_data)
        # Some passive business logic will be triggered by the recharged action
        recharge(instance)
        return instance


class WalletAmtDisViewSerializer(serializers.Serializer):
    min = serializers.FloatField()
    max = serializers.FloatField()
