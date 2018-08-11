from rest_framework import serializers
from app01 import models


class VoucherSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Voucher
        fields = '__all__'

    def create(self, validated_data):
        if validated_data['voucher_code']:
            lasted_voucher = models.Voucher.objects.last()
            if lasted_voucher:
                validated_data['voucher_code'] += "-%05d" % (lasted_voucher.pk + 1)
            else:
                validated_data['voucher_code'] += "-%05d" % 1
        instance = super(VoucherSerializer, self).create(validated_data)
        # instance.voucher_code += "-%05d" % instance.pk
        instance.save()
        return instance
