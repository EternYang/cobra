from rest_framework import viewsets
from rest_framework.response import Response
from app01 import models
from . import serializers
from utils.pagination import DefaultPagination
from .permissions import EvaluationViewSetPermission, TransactionAndTransactDetailsViewSetPermission
from utils.permissions import IsAdmin
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from django_filters import rest_framework as filters
from rest_framework.exceptions import PermissionDenied
from rest_framework import status
from utils.query_filter import get_page


class TransactionFilter(filters.FilterSet):
    min_transact_datetime = filters.DateTimeFilter(name="transact_datetime", lookup_expr='gte')
    max_transact_datetime = filters.DateTimeFilter(name="transact_datetime", lookup_expr='lte')

    class Meta:
        model = models.Transaction
        fields = ['member', 'outlet', 'receipt_no', 'pos_no', 'cashier_no', 'min_transact_datetime',
                  'min_transact_datetime']


class TransactDetailsFilter(filters.FilterSet):
    min_transact_datetime = filters.DateTimeFilter(name="transaction__transact_datetime", lookup_expr='gte')
    max_transact_datetime = filters.DateTimeFilter(name="transaction__transact_datetime", lookup_expr='lte')
    product_tea_base = filters.CharFilter(name="product__tea_base", lookup_expr='icontains')
    category_name = filters.CharFilter(name="product__category__name", lookup_expr='icontains')
    toppings_name = filters.CharFilter(name="toppings__name", lookup_expr='icontains')
    size = filters.NumberFilter(name="product__size")

    class Meta:
        model = models.TransactDetails
        fields = ('method', 'ice_level', 'sugar_level', 'transaction__member', 'size', 'min_transact_datetime',
                  'max_transact_datetime', 'category_name', 'toppings_name', 'product_tea_base')


class EvaluationFilter(filters.FilterSet):
    min_created = filters.DateTimeFilter(name="created", lookup_expr='gte')
    max_created = filters.DateTimeFilter(name="created", lookup_expr='lte')

    class Meta:
        model = models.Evaluation
        fields = ['transaction', ]


class TransactionViewSet(viewsets.ModelViewSet):
    permission_classes = (TransactionAndTransactDetailsViewSetPermission,)
    queryset = models.Transaction.objects.all()
    serializer_class = serializers.TransactionCSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = TransactionFilter
    search_fields = ('member__id', 'outlet__id', 'receipt_no', 'pos_no', 'cashier_no')
    ordering_fields = ('member', 'outlet', 'receipt_no', 'pos_no', 'cashier_no', 'total_money', 'transact_datetime')

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'transact_details__product__category',
            'transact_details__toppings',
            'outlet', 'campaigns', 'campaigntypes',
            'reward_vouchers',
            'redeemed_vouchers',
        )
        if self.request.user.role.name not in (0, 1, 4):
            self.queryset = self.queryset.filter(member=self.request.user)
        return super(TransactionViewSet, self).get_queryset()

    def get_serializer_class(self):
        if self.request.method == "GET":
            return serializers.TransactionRSerializer
        else:
            return super(TransactionViewSet, self).get_serializer_class()


class TransactDetailsViewSet(viewsets.ModelViewSet):
    permission_classes = (TransactionAndTransactDetailsViewSetPermission,)
    queryset = models.TransactDetails.objects.all()
    serializer_class = serializers.TransactDetailsCSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = TransactDetailsFilter
    search_fields = ('transaction__receipt_no', 'product__name')

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'transaction',
            'product__category',
            'toppings',
        )
        if self.request.user.role.name not in (0, 1, 4):
            self.queryset = self.queryset.filter(transaction__member=self.request.user)
        return super(TransactDetailsViewSet, self).get_queryset()

    def get_serializer_class(self):
        if self.request.method == "GET":
            return serializers.TransactDetailsRSerializer
        else:
            return super(TransactDetailsViewSet, self).get_serializer_class()


class EvaluationViewSet(viewsets.ModelViewSet):
    permission_classes = (EvaluationViewSetPermission,)
    queryset = models.Evaluation.objects.all()
    serializer_class = serializers.EvaluationSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = EvaluationFilter
    search_fields = ('transaction',)
    ordering_fields = ('transaction', 'created')

    def get_queryset(self):
        ret = super(EvaluationViewSet, self).get_queryset()
        if self.request.user.role.name in (0, 1, 4):
            return ret
        else:
            return ret.filter(transaction__member=self.request.user)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        transaction = serializer.validated_data.get('transaction')
        if not transaction.member == request.user:
            raise PermissionDenied()
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class SalesRecordViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.Product.objects.all()
    serializer_class = serializers.SalesRecordSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_fields = {'name': 'app01_product.name', 'tea_base': 'app01_product.tea_base',
                     'category_name': 'app01_category.name'}
    int_filter_fields = {'size': 'app01_product.size'}
    date_filter_fields = {'min_transact_datetime': ('app01_transaction.transact_datetime', '>='),
                          'max_transact_datetime': ('app01_transaction.transact_datetime', '<=')}
    search_fields = ['app01_product.name', 'app01_category.name']
    ordering_fields = {'price': 'app01_product.price', 'amount': 'amount'}

    def list(self, request, *args, **kwargs):
        sql = """SELECT "app01_category"."name" AS "category_name", "app01_product"."id", "app01_product"."name", "app01_product"."description", "app01_product"."price", "app01_product"."tea_base", "app01_product"."item_code", "app01_product"."category_id", "app01_product"."created", COALESCE(SUM("app01_transactdetails"."quantity"), 0) AS "amount"
 FROM "app01_product"
 INNER JOIN "app01_transactdetails" ON ("app01_product"."id" = "app01_transactdetails"."product_id")
 INNER JOIN "app01_transaction" ON ("app01_transactdetails"."transaction_id" = "app01_transaction"."id")
 INNER JOIN "app01_category" ON ("app01_product"."category_id" = "app01_category"."id")
 GROUP BY "app01_product"."id",  "app01_category"."id" """

        # filter sql
        filter_sql = ''
        total_filter_fields_keys = []
        filter_fields_keys = self.filter_fields.keys()
        date_filter_fields_keys = self.date_filter_fields.keys()
        int_filter_fields_keys = self.int_filter_fields.keys()
        total_filter_fields_keys.extend(filter_fields_keys)
        total_filter_fields_keys.extend(date_filter_fields_keys)
        total_filter_fields_keys.extend(int_filter_fields_keys)
        filter_fields_dict = {}
        for filter_field_key in total_filter_fields_keys:
            filter_field_value = request.GET.get(filter_field_key)
            if filter_field_value:
                filter_fields_dict[filter_field_key] = filter_field_value
        if filter_fields_dict:
            filter_sql += ' WHERE '
            for filter_field_key, filter_field_value in filter_fields_dict.items():
                if filter_sql != ' WHERE ':
                    filter_sql += ' AND '
                if filter_field_key in date_filter_fields_keys:
                    filter_sql += ' {0} {1} '.format(self.date_filter_fields[filter_field_key][0],
                                                     self.date_filter_fields[filter_field_key][
                                                         1]) + " '{0}'::timestamptz ".format(filter_field_value)
                elif filter_field_key in int_filter_fields_keys:
                    filter_sql += ' {0} = {1}'.format(self.int_filter_fields[filter_field_key], filter_field_value)
                else:
                    filter_sql += ' UPPER({0}) '.format(
                        self.filter_fields[filter_field_key]) + "LIKE UPPER('%%{0}%%') ".format(filter_field_value)

        # search sql
        search_sql = ''
        search_value = request.GET.get('search')
        if search_value:
            search_sql += ' WHERE ( ' if filter_sql == '' else ' AND ( '
            for search_field in self.search_fields:
                if search_sql not in (' WHERE ( ', ' AND ( '):
                    search_sql += ' OR '
                search_sql += ' UPPER({0}) '.format(search_field) + "LIKE UPPER('%%{0}%%') ".format(search_value)
            else:
                search_sql += ' ) '
        # where sql(filter sql + search sql)
        where_sql = filter_sql + search_sql
        # Order by products_sold, products_sold_incr, turnover, turnover_incr
        order_sql = ''
        order_field_key = request.GET.get('ordering')
        ordering_fields_keys = self.ordering_fields.keys()
        desc_ordering_fields_keys = ['-%s' % i for i in ordering_fields_keys]
        if order_field_key in ordering_fields_keys:
            order_sql = " order by %s " % self.ordering_fields[order_field_key]
        elif order_field_key in desc_ordering_fields_keys:
            order_sql = " order by %s desc " % self.ordering_fields[order_field_key[1:]]
        # get page
        page_size, page = get_page(request, self.paginator.page_size)
        # limit sql
        limit_sql = ' limit %s offset %s ' % (page_size, (page - 1) * page_size)
        # group by sql
        group_by_sql = ' GROUP BY "app01_product"."id",  "app01_category"."id" '
        # all sql
        if not where_sql == '':
            group_by_index = sql.index('GROUP BY')
            sql = sql[:group_by_index]
            all_sql = sql + where_sql + group_by_sql + order_sql + limit_sql
        else:
            all_sql = sql + where_sql + order_sql + limit_sql
        all_queryset = models.Product.objects.raw(all_sql)
        all_queryset = list(all_queryset)
        # for i in all_queryset:
        #     print(i.__dict__)
        serializer = self.get_serializer(all_queryset, many=True)
        # Pagination
        from collections import OrderedDict
        return Response(OrderedDict([
            ('count', len(all_queryset)),
            # ('next', self.get_next_link()),
            # ('previous', self.get_previous_link()),
            ('results', serializer.data)
        ]))
