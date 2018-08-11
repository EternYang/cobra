from rest_framework import viewsets
from utils.pagination import DefaultPagination
from app01 import models
from . import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from .permissions import MembershipViewSetPermission
from utils.utils import get_sorted_key_func
from django.db.models import Count


class MembershipViewSet(viewsets.ModelViewSet):
    permission_classes = (MembershipViewSetPermission,)
    queryset = models.Membership.objects.all()
    serializer_class = serializers.MembershipSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_fields = ('state',)
    search_fields = ('name',)

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related('members', 'complimentary_vouchers', 'birthday_vouchers')
        return super(MembershipViewSet, self).get_queryset()

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset()).annotate(num_of_membership=Count('members'))
        serializer = self.get_serializer(queryset, many=True)
        ret = serializer.data
        # Order by num_of_membership
        order_field = request.GET.get('ordering')
        order_fields = ['num_of_membership']
        desc_order_fields = ['-num_of_membership']
        if order_field in order_fields:
            sorted_key_func = get_sorted_key_func(order_field)
            ret = sorted(ret, key=sorted_key_func)
        elif order_field in desc_order_fields:
            sorted_key_func = get_sorted_key_func(order_field[1:])
            ret = sorted(ret, key=sorted_key_func, reverse=True)
        # Pagination
        page = self.paginate_queryset(ret)
        response = self.get_paginated_response(page)
        return response
