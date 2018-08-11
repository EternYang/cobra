from rest_framework import serializers
from app01 import models


class OutletSerializer(serializers.ModelSerializer):
    satisfaction = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Outlet
        fields = '__all__'


class OutletNameSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Outlet
        fields = ['id', 'outlet_name']


class OutletDistrictSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Outlet
        fields = ['id', 'outlet_district']


class OutletPerformanceSerializer(serializers.ModelSerializer):
    products_sold = serializers.FloatField(required=False, allow_null=True)
    products_sold_incr = serializers.FloatField(required=False, allow_null=True)
    turnover = serializers.FloatField(required=False, allow_null=True)
    turnover_incr = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Outlet
        fields = '__all__'
