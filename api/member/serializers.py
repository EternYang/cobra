from rest_framework import serializers
from django.db import transaction
from django.utils import timezone
from app01 import models
from utils.utils import except_validation_error
from .services import supplement_info, bind_email, update_membership, create_member, encrypted_or_reset_password
from django.core.exceptions import ObjectDoesNotExist
from membership.services import get_initial_membership_level
from utils.utils import transaction_wrapper
from membership.serializers import MembershipSerializer


@transaction_wrapper
def set_interest(interest_group_datas, member):
    """Set a member's interest groups"""
    for interest_group_data in interest_group_datas:
        if models.InterestGroup.objects.filter(name=interest_group_data.get('name')).exists():
            interest_group = models.InterestGroup.objects.get(name=interest_group_data.get('name'))
        else:
            serializer = InterestGroupSerializer(data=interest_group_data)
            serializer.is_valid(raise_exception=True)
            interest_group = serializer.save()
        member.interestGroups.add(interest_group)
    member.save()


@transaction_wrapper
def reset_interest(interest_group_datas, member):
    """Reset a member's interest groups"""
    member.interestGroups.clear()
    set_interest(interest_group_datas, member)


class InterestGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.InterestGroup
        fields = '__all__'


class Member_CampaignTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Member_CampaignType
        exclude = ('id',)


class Voucher_MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Voucher_Member
        exclude = ('id',)


class Points_MemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Points_Member
        exclude = ('id',)


class MembershipMemberSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Membership_Member
        exclude = ('id',)


class FullMemberCUSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Member
        exclude = ('role', 'interestGroups', 'vouchers')

    @except_validation_error
    def create(self, validated_data):
        role = models.Role.objects.get(name=2)
        validated_data['role'] = role
        instance = super(FullMemberCUSerializer, self).create(validated_data)
        # Some passive business logic will be triggered by the creation of new members
        create_member(instance)
        # Set this member's interest groups
        if self.initial_data.get('interestGroups'):
            set_interest(self.initial_data.get('interestGroups'), instance)
        # Create a record of membership level periodic table
        update_membership(instance, instance.membership)
        return instance

    @except_validation_error
    def update(self, instance, validated_data):
        instance = super(FullMemberCUSerializer, self).update(instance, validated_data)
        # Reset password
        encrypted_or_reset_password(instance, instance.password)
        # Reset this member's interest groups
        if self.initial_data.get('interestGroups'):
            reset_interest(self.initial_data.get('interestGroups'), instance)
        # Update a record of membership level periodic table
        if validated_data.get('membership'):
            update_membership(instance, instance.membership)
        return instance


class FullMemberReadSerializer(serializers.ModelSerializer):
    membership_members = MembershipMemberSerializer(many=True, read_only=True)
    member_campaigntypes = Member_CampaignTypeSerializer(many=True, read_only=True)
    voucher_members = Voucher_MemberSerializer(many=True, read_only=True)
    points = Points_MemberSerializer(many=True, read_only=True)
    membership = MembershipSerializer(read_only=True)

    class Meta:
        model = models.Member
        exclude = ('vouchers', 'campaigntypes')
        depth = 2


class BasicMemberUSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Member
        exclude = ('last_login', 'mobile_no', 'username', 'password', 'registration_date', 'role', 'interestGroups',
                   'vouchers', 'dob')

    @except_validation_error
    def update(self, instance, validated_data):
        instance = super(BasicMemberUSerializer, self).update(instance, validated_data)
        # Member can get bonus points by binding emails
        bind_email(validated_data, instance)
        # Member's supplementary information can get bonus points
        supplement_info(validated_data, instance)
        # Reset this member's interest groups
        reset_interest(self.initial_data, instance)
        return instance


class BasicMemberReadSerializer(serializers.ModelSerializer):
    membership_members = MembershipMemberSerializer(many=True, read_only=True)
    member_campaigntypes = Member_CampaignTypeSerializer(many=True, read_only=True)
    voucher_members = Voucher_MemberSerializer(many=True, read_only=True)
    points = Points_MemberSerializer(many=True, read_only=True)
    membership = MembershipSerializer(read_only=True)

    class Meta:
        model = models.Member
        exclude = ('password', 'vouchers', 'campaigntypes')
        depth = 2


class LoginSerializer(serializers.Serializer):
    password = serializers.CharField(
        required=True, style={'input_type': 'password'}
    )
    username = serializers.CharField(required=False)

    def __init__(self, *args, **kwargs):
        super(LoginSerializer, self).__init__(*args, **kwargs)
        self.fields[models.Member.USERNAME_FIELD] = serializers.CharField(
            required=False
        )

    def create(self, validated_data):
        try:
            if validated_data.get('username'):
                user = models.Member.objects.get(username=validated_data.get('username'))
            else:
                user = models.Member.objects.get(mobile_no=validated_data.get('mobile_no'))
            ret = user.check_password(validated_data.get('password'))
        except ObjectDoesNotExist as e:
            return models.Token.objects.none()
        if ret:
            user.last_login = timezone.now()
            token, _ = models.Token.objects.get_or_create(user=user)
        else:
            token = models.Token()
        return token


class LoginSerializer1(serializers.Serializer):
    password = serializers.CharField(
        required=True, style={'input_type': 'password'}
    )
    username = serializers.CharField(required=False)

    def __init__(self, *args, **kwargs):
        super(LoginSerializer, self).__init__(*args, **kwargs)
        self.fields[models.Member.USERNAME_FIELD] = serializers.CharField(
            required=False
        )

    def create(self, validated_data):
        try:
            if validated_data.get('email'):
                user = models.Member.objects.get(email=validated_data.get('email'))
            # else:
                # user = models.Member.objects.get(mobile_no=validated_data.get('mobile_no'))
            ret = user.check_password(validated_data.get('password'))
        except ObjectDoesNotExist as e:
            return models.Token.objects.none()
        if ret:
            user.last_login = timezone.now()
            token, _ = models.Token.objects.get_or_create(user=user)
        else:
            token = models.Token()
        return token


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Member
        fields = ('mobile_no', 'password', 'dob')

    def create(self, validated_data):
        with transaction.atomic():
            validated_data['username'] = validated_data.get('mobile_no')
            init_membership = get_initial_membership_level()
            if init_membership:
                validated_data['membership'] = init_membership
                role = models.Role.objects.get(name=2)
                validated_data['role'] = role
                instance = super(RegisterSerializer, self).create(validated_data)
                create_member(instance)
                return instance


class RegisterSerializer1(serializers.ModelSerializer):
    class Meta:
        model = models.Member
        fields = ('email', 'password', 'dob', 'mobile_no', "nick_name")

    def create(self, validated_data):
        with transaction.atomic():
            validated_data['username'] = validated_data.get('email')
            init_membership = get_initial_membership_level()
            if init_membership:
                validated_data['membership'] = init_membership
                role = models.Role.objects.get(name=2)
                validated_data['role'] = role
                instance = super(RegisterSerializer1, self).create(validated_data)
                create_member(instance)
                return instance