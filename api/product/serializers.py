from rest_framework import serializers
from app01 import models


class ProductTeaBaseSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Product
        fields = ('tea_base',)


class ToppingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Toppings
        fields = "__all__"


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Category
        fields = "__all__"


class ProductRSerializer(serializers.ModelSerializer):
    satisfaction = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Product
        fields = "__all__"
        depth = 2


class ProductPerformanceSerializer(serializers.ModelSerializer):
    products_sold = serializers.FloatField(required=False, allow_null=True)
    products_sold_incr = serializers.FloatField(required=False, allow_null=True)
    turnover = serializers.FloatField(required=False, allow_null=True)
    turnover_incr = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Product
        fields = "__all__"
        depth = 2


class ProductCUDSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Product
        fields = "__all__"
