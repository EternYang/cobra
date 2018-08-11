from rest_framework import viewsets
from utils.pagination import DefaultPagination
from app01 import models
from . import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from .permissions import OutletViewSetPermission
from django_filters import rest_framework as filters
from django.db.models.functions import Coalesce
from django.db.models import Sum, Count, Avg
from django_filters import Filter
from django_filters.fields import Lookup
from utils.permissions import IsAdmin


class ListFilter(Filter):
    def filter(self, qs, value):
        value_list = value.split(u',')
        return super(ListFilter, self).filter(qs, Lookup(value_list, 'in'))


class OutletFilter(filters.FilterSet):
    outlet_name = ListFilter(name="outlet_name", lookup_expr='icontains')
    outlet_district = filters.CharFilter(name="outlet_district", lookup_expr='icontains')

    class Meta:
        model = models.Outlet
        fields = ('outlet_name', 'outlet_district')


class OutletViewSet(viewsets.ModelViewSet):
    permission_classes = (OutletViewSetPermission,)
    queryset = models.Outlet.objects.all()
    serializer_class = serializers.OutletSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = OutletFilter
    search_fields = ('outlet_name',)

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'transaction__evaluation'
        ).annotate(
            satisfaction=Coalesce(Avg('transaction__evaluation__service_satisfaction'), 0))
        return super(OutletViewSet, self).get_queryset()


class OutletNameViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.Outlet.objects.all().only('id', 'outlet_name').distinct('outlet_name')
    serializer_class = serializers.OutletNameSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )


class OutletDistrictViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.Outlet.objects.all().only('id', 'outlet_district').distinct('outlet_district')
    serializer_class = serializers.OutletDistrictSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
