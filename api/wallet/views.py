from rest_framework import viewsets, mixins
from rest_framework.response import Response
from utils.pagination import DefaultPagination
from app01 import models
from . import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from utils.permissions import IsAdmin, IsApp
from .permissions import RechargeRecordViewSetPermission, WalletViewSetPermission
from django.db.models import Q, Sum
from rest_framework import status
from django_filters import rest_framework as filters
from django.db.models.functions import Coalesce
from rest_framework.decorators import action


class WalletFilter(filters.FilterSet):
    min_lastest_top_up = filters.DateTimeFilter(name="lastest_top_up", lookup_expr='gte')
    max_lastest_top_up = filters.DateTimeFilter(name="lastest_top_up", lookup_expr='lte')

    class Meta:
        model = models.Wallet
        fields = ('min_lastest_top_up', 'max_lastest_top_up')


class WalletViewSet(mixins.UpdateModelMixin,
                    mixins.ListModelMixin,
                    mixins.RetrieveModelMixin,
                    viewsets.GenericViewSet):
    permission_classes = (WalletViewSetPermission,)
    queryset = models.Wallet.objects.all()
    serializer_class = serializers.WalletSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = WalletFilter
    search_fields = ('member__name',)
    ordering_fields = ('balance', 'total_consumption')
    ordering = ('id',)

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'member__transaction',
        ).annotate(
            total_consumption=Coalesce(Sum('member__transaction__total_money'), 0)
        )
        if self.request.user.role.name not in (0, 1, 4):
            self.queryset = self.queryset.filter(member=self.request.user)
        return super(WalletViewSet, self).get_queryset()

    @action(methods=['POST'], detail=True, permission_classes=[IsApp])
    def deduction(self, request, pk=None, **kwargs):
        wallet = models.Wallet.objects.filter(pk=pk).first()
        if not wallet:
            return Response(status=status.HTTP_404_NOT_FOUND)
        try:
            consumption_amount = float(request.data.get('amount'))
        except Exception:
            return Response({"error": "Invalid amount."}, status=status.HTTP_400_BAD_REQUEST)

        if wallet.balance < consumption_amount:
            return Response({"error": "The balance is not enough."}, status=status.HTTP_400_BAD_REQUEST)
        wallet.balance -= consumption_amount
        wallet.save()
        return Response(status=status.HTTP_204_NO_CONTENT)


class RechargeRecordViewSet(mixins.CreateModelMixin,
                            mixins.ListModelMixin,
                            mixins.RetrieveModelMixin,
                            viewsets.GenericViewSet):
    permission_classes = (RechargeRecordViewSetPermission,)
    queryset = models.RechargeRecord.objects.all()
    serializer_class = serializers.RechargeRecordCreateSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_fields = ('wallet',)
    search_fields = ('wallet',)
    ordering_fields = ('wallet',)

    def get_serializer_class(self):
        if self.request.method == "POST":
            return serializers.RechargeRecordCreateSerializer
        else:
            return serializers.RechargeRecordListSerializer

    def get_queryset(self):
        ret = super(RechargeRecordViewSet, self).get_queryset()
        if self.request.user.role.name == 4:
            return ret
        else:
            return ret.filter(wallet=self.request.user.wallet)


class WalletAmtDisView(mixins.ListModelMixin, viewsets.GenericViewSet):
    permission_classes = (IsAdmin,)
    serializer_class = serializers.WalletAmtDisViewSerializer
    queryset = models.Wallet.objects.all()

    def list(self, request, *args, **kwargs):
        min_no = request.GET.get('min')
        max_no = request.GET.get('max')
        serializer = self.get_serializer(data={'min': min_no, 'max': max_no})
        serializer.is_valid(raise_exception=True)
        con = Q()
        con.children.append(('balance__lte', max_no))
        con.children.append(('balance__gte', min_no))
        count = models.Wallet.objects.filter(con).count()
        ret = {}
        ret.update(serializer.data)
        ret.update({'count': count})
        return Response(ret, status=status.HTTP_200_OK)
