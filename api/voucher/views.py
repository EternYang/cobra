from rest_framework import viewsets
from utils.pagination import DefaultPagination
from app01 import models
from . import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from .permissions import VoucherViewSetPermission
from django_filters import rest_framework as filters
from django_filters import Filter
from django_filters.fields import Lookup


class ListFilter(Filter):
    def filter(self, qs, value):
        value_list = value.split(u',')
        return super(ListFilter, self).filter(qs, Lookup(value_list, 'in'))


class VoucherFilter(filters.FilterSet):
    min_effective_date = filters.DateTimeFilter(name="effective_date", lookup_expr='gte')
    max_effective_date = filters.DateTimeFilter(name="effective_date", lookup_expr='lte')
    min_expiring_date = filters.DateTimeFilter(name="expiring_date", lookup_expr='gte')
    max_expiring_date = filters.DateTimeFilter(name="expiring_date", lookup_expr='lte')
    type = ListFilter(name="type", lookup_expr='icontains')
    state = ListFilter(name="state", lookup_expr='icontains')
    #

    class Meta:
        model = models.Voucher
        fields = ('state', 'type', 'min_effective_date', 'max_effective_date', 'max_expiring_date',
                  'max_expiring_date')


class VoucherViewSet(viewsets.ModelViewSet):
    permission_classes = (VoucherViewSetPermission,)
    queryset = models.Voucher.objects.all()
    serializer_class = serializers.VoucherSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = VoucherFilter
    search_fields = ('name',)
    ordering_fields = ['id']

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'redemption_toppings',
            'redemption_products',
            # 'size_upgrade_unparticipated_products',
            # 'discount_per_unparticipated_products',
            # 'discount_price_unparticipated_products',
            'unparticipated_outlets', 'limit_memberships'
        )
        return super(VoucherViewSet, self).get_queryset()
