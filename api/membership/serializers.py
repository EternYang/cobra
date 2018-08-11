from rest_framework import serializers
from app01 import models


class MembershipSerializer(serializers.ModelSerializer):
    num_of_membership = serializers.FloatField(required=False, allow_null=True)

    class Meta:
        model = models.Membership
        fields = '__all__'
