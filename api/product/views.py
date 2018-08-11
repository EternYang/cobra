from rest_framework import viewsets
from app01 import models
from . import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from .permissions import ProductViewSetPermission, ToppingsViewSetPermission, CategoryViewSetPermission
from django_filters import rest_framework as filters
from django.db.models import Sum, Count, Avg
from django.db.models.functions import Coalesce


class ProductFilter(filters.FilterSet):
    category_name = filters.CharFilter(name="category__name", lookup_expr='icontains')
    tea_base = filters.CharFilter(name="tea_base", lookup_expr='icontains')

    class Meta:
        model = models.Product
        fields = ['category_name', 'tea_base']


class ProductViewSet(viewsets.ModelViewSet):
    permission_classes = (ProductViewSetPermission,)
    queryset = models.Product.objects.all()
    serializer_class = serializers.ProductCUDSerializer
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = ProductFilter
    search_fields = ('name',)
    ordering_fields = ('satisfaction',)

    def get_serializer_class(self):
        if self.request.method == "GET":
            return serializers.ProductRSerializer
        else:
            return super(ProductViewSet, self).get_serializer_class()

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'transact_details__transaction__evaluation',
            'category'
        ).annotate(
            satisfaction=Coalesce(Avg('transact_details__transaction__evaluation__product_quality_satisfaction'), 0))
        return super(ProductViewSet, self).get_queryset()


class ToppingsViewSet(viewsets.ModelViewSet):
    permission_classes = (ToppingsViewSetPermission,)
    queryset = models.Toppings.objects.all()
    serializer_class = serializers.ToppingsSerializer
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )


class CategoryViewSet(viewsets.ModelViewSet):
    permission_classes = (CategoryViewSetPermission,)
    queryset = models.Category.objects.all()
    serializer_class = serializers.CategorySerializer
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )


class ProductTeaBaseViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = []
    queryset = models.Product.objects.all()
    serializer_class = serializers.ProductTeaBaseSerializer
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )

    def get_queryset(self):
        self.queryset = self.queryset.filter(tea_base__isnull=False).only('tea_base').distinct('tea_base')
        return super(ProductTeaBaseViewSet, self).get_queryset()
