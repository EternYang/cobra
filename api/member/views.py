from rest_framework import viewsets
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from app01 import models
from . import serializers
from utils.pagination import DefaultPagination
from .permissions import MemberViewSetPermission
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from django_filters import rest_framework as filters
from django_filters import Filter
from django_filters.fields import Lookup


class ListFilter(Filter):
    def filter(self, qs, value):
        value_list = value.split(u',')
        return super(ListFilter, self).filter(qs, Lookup(value_list, 'in'))


class MemberFilter(filters.FilterSet):
    race = ListFilter(name="race", lookup_expr='icontains')
    race_exclude = ListFilter(name="race", lookup_expr='icontains', exclude=True)
    membership_name = ListFilter(name="membership__name", lookup_expr='icontains')
    membership_name_exclude = ListFilter(name="membership__name", lookup_expr='icontains', exclude=True)
    min_registration_date = filters.DateTimeFilter(name="registration_date", lookup_expr='gte')
    max_registration_date = filters.DateTimeFilter(name="registration_date", lookup_expr='lte')
    min_last_purchase_date = filters.DateTimeFilter(name="last_purchase_date", lookup_expr='gte')
    max_last_purchase_date = filters.DateTimeFilter(name="last_purchase_date", lookup_expr='lte')

    class Meta:
        model = models.Member
        fields = (
            'name', 'race', 'race_exclude', 'membership_name', 'membership_name_exclude', 'min_registration_date',
            'max_registration_date',
            'min_last_purchase_date',
            'max_last_purchase_date')


class MemberViewSet(viewsets.ModelViewSet):
    permission_classes = (MemberViewSetPermission,)
    queryset = models.Member.objects.all()
    serializer_class = serializers.FullMemberCUSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = MemberFilter
    search_fields = ('name',)

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'role',
            'membership',
            'points',
            'voucher_members',
            'membership_members',
            'membership__complimentary_vouchers',
            'membership__birthday_vouchers',
            'member_campaigntypes',
            'interestGroups',
        )
        if self.request.user.role.name not in (0, 1):
            self.queryset = self.queryset.filter(pk=self.request.user.pk)
        return super(MemberViewSet, self).get_queryset()

    def get_serializer_class(self):
        if self.request.method == 'GET':
            if self.request.user.role.name in (0, 1):
                return serializers.FullMemberReadSerializer
            else:
                return serializers.BasicMemberReadSerializer
        else:
            if self.request.user.role.name in (0, 1):
                return super(MemberViewSet, self).get_serializer_class()
            else:
                return serializers.BasicMemberUSerializer


class LoginView(generics.GenericAPIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    serializer_class = serializers.LoginSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        token = serializer.save()
        if not token:
            return Response({'msg': 'username is not exist'}, status=status.HTTP_401_UNAUTHORIZED)
        if not token.pk:
            return Response({'msg': 'wrong user name or password'}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            response = Response({'token': token.key})
            # response.setdefault('Authorization', 'Token {auth_token}'.format(auth_token=token.key))
            # response.set_cookie(
            #     'Authorization',
            #     value='Token {auth_token}'.format(auth_token=token.key),
            #     httponly=True
            # )
            return response



class LoginView1(generics.GenericAPIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    serializer_class = serializers.LoginSerializer1

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        token = serializer.save()
        if not token:
            return Response({'msg': 'username is not exist'}, status=status.HTTP_401_UNAUTHORIZED)
        if not token.pk:
            return Response({'msg': 'wrong user name or password'}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            response = Response({'token': token.key})
            # response.setdefault('Authorization', 'Token {auth_token}'.format(auth_token=token.key))
            # response.set_cookie(
            #     'Authorization',
            #     value='Token {auth_token}'.format(auth_token=token.key),
            #     httponly=True
            # )
            return response


class RegisterView(generics.GenericAPIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    serializer_class = serializers.RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        member = serializer.save()
        return Response({
            'id': member.pk,
            'username': member.username,
            'mobile_no': member.mobile_no,
            'dob': member.dob,
        }, status=status.HTTP_201_CREATED)


class RegisterByEmailView(generics.GenericAPIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    serializer_class = serializers.RegisterSerializer1

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        member = serializer.save()
        return Response({
            'id': member.pk,
            'username': member.username,
            'email': member.email,
            "mobile_no": member.mobile_no,
            'dob': member.dob,
            "nick_name": member.nick_name
        }, status=status.HTTP_201_CREATED)