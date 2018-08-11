from rest_framework import viewsets
from utils.pagination import DefaultPagination
from utils.permissions import IsAdmin
from app01 import models
from . import serializers
from .permissions import CampaignViewSetPermission
import datetime
from rest_framework.filters import SearchFilter, OrderingFilter
from django_filters.rest_framework import DjangoFilterBackend
from django_filters import rest_framework as filters
from utils.utils import get_sorted_key_func
from product.serializers import ProductPerformanceSerializer
from outlet.serializers import OutletPerformanceSerializer
from django.db.models import Sum, Count
from rest_framework.response import Response
from rest_framework import status
from utils.utils import fun_timer
from utils.query_filter import get_page
from django.db.models.functions import Coalesce


class CampaignFilter(filters.FilterSet):
    min_effective_date = filters.DateTimeFilter(name="effective_date", lookup_expr='gte')
    max_effective_date = filters.DateTimeFilter(name="effective_date", lookup_expr='lte')
    min_expiring_date = filters.DateTimeFilter(name="expiring_date", lookup_expr='gte')
    max_expiring_date = filters.DateTimeFilter(name="expiring_date", lookup_expr='lte')

    class Meta:
        model = models.Campaign
        fields = ('state', 'min_effective_date', 'max_effective_date', 'min_expiring_date', 'max_expiring_date')


class OccupationViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.Occupation.objects.all()
    serializer_class = serializers.OccupationSerializer
    pagination_class = DefaultPagination
    filter_fields = ('name',)
    search_fields = ('name',)
    ordering_fields = ('name',)


class CampaignTypeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.CampaignType.objects.all()
    serializer_class = serializers.CampaignTypeSerializer
    pagination_class = DefaultPagination
    filter_fields = ('campaign', 'campaign_condition',)
    search_fields = ('campaign', 'campaign_condition',)
    ordering_fields = ('campaign', 'campaign_condition',)

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related('free_vouchers')
        return super(CampaignTypeViewSet, self).get_queryset()


class CampaignConditionViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.CampaignCondition.objects.all()
    serializer_class = serializers.CampaignConditionSerializer
    pagination_class = DefaultPagination
    filter_fields = ('campaign',)
    search_fields = ('campaign',)
    ordering_fields = ('campaign',)

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related('every_purchase_m_drinks_flavors',
                                                       'every_purchase_l_drinks_flavors',
                                                       'every_purchase_products')
        return super(CampaignConditionViewSet, self).get_queryset()


class CampaignViewSet(viewsets.ModelViewSet):
    permission_classes = (CampaignViewSetPermission,)
    queryset = models.Campaign.objects.all()
    serializer_class = serializers.CampaignCUDSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_class = CampaignFilter
    search_fields = ['name']
    ordering_fields = ['turnover', 'products_sold', 'transactions_count']

    def get_queryset(self):
        self.queryset = self.queryset.prefetch_related(
            'campaigntypes__campaign_condition__every_purchase_m_drinks_flavors',
            'campaigntypes__campaign_condition__every_purchase_l_drinks_flavors',
            'campaigntypes__campaign_condition__every_purchase_products',
            'campaigntypes__free_vouchers',
            'occupations', 'memberships', 'outlets',
            'transactions__transact_details'
        ).annotate(
            transactions_count=Coalesce(Count('transactions__id', distinct=True), 0),
            turnover=Coalesce(Sum('transactions__transact_details__price'), 0),
            products_sold=Coalesce(Sum('transactions__transact_details__quantity'), 0))
        if self.request.user.role.name != 0:
            self.queryset = self.queryset.filter(effective_date__lt=datetime.datetime.now(),
                                                 expiring_date__gt=datetime.datetime.now())
        return super(CampaignViewSet, self).get_queryset()

    def get_serializer_class(self):
        if self.request.method == "GET":
            return serializers.CampaignRSerializer
        else:
            return super(CampaignViewSet, self).get_serializer_class()

    # @fun_timer
    # def list(self, request, *args, **kwargs):
    #     queryset = self.filter_queryset(self.get_queryset())
    #     serializer = self.get_serializer(queryset, many=True)
    #     ret = serializer.data
    #     # Order by turnover, products_sold, transactions
    #     order_field = request.GET.get('ordering')
    #     order_fields = ['turnover', 'products_sold', 'transactions']
    #     desc_order_fields = ['-turnover', '-products_sold', '-transactions']
    #     if order_field in order_fields:
    #         sorted_key_func = get_sorted_key_func(order_field)
    #         ret = sorted(ret, key=sorted_key_func)
    #     elif order_field in desc_order_fields:
    #         sorted_key_func = get_sorted_key_func(order_field[1:])
    #         ret = sorted(ret, key=sorted_key_func, reverse=True)
    #     # Pagination
    #     page = self.paginate_queryset(ret)
    #     response = self.get_paginated_response(page)
    #     return response


class CampaignPerformanceOfProductViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.Product.objects.all()
    serializer_class = ProductPerformanceSerializer
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_fields = ['category_name', 'tea_base']
    search_fields = ['name']
    ordering_fields = ['products_sold', 'products_sold_incr', 'turnover', 'turnover_incr']

    def list(self, request, *args, **kwargs):
        # the campaign performance of products
        campaign_id = request.GET.get('campaign_id')
        if not campaign_id:
            return Response({'msg': 'Please input campaign_id in url parameters, e.g. http://{url}?campaign_id=1'},
                            status=status.HTTP_403_FORBIDDEN)
        campaign = models.Campaign.objects.filter(pk=campaign_id).filter(pk=campaign_id).first()
        if not campaign:
            return Response({'msg': 'The campaign_id is not exist'}, status=status.HTTP_403_FORBIDDEN)
        # previous campaign
        pre_campaign = models.Campaign.objects.filter(effective_date__lt=campaign.effective_date).order_by(
            '-effective_date').first()
        if not pre_campaign:
            pre_campaign_id = 0
        else:
            pre_campaign_id = pre_campaign.pk
        sql = """select *,COALESCE(turnover1, 0) AS turnover,COALESCE(products_sold1, 0) AS products_sold,COALESCE((turnover1-pre_turnover)/pre_turnover, 0) AS turnover_incr,COALESCE((products_sold1-pre_products_sold)/pre_products_sold, 0) AS products_sold_incr from
	(
		select A.*,B.*,app01_category.name AS category_name from
			(SELECT "app01_product"."id", "app01_product"."name", "app01_product"."description", "app01_product"."price", "app01_product"."tea_base", "app01_product"."item_code", "app01_product"."category_id", "app01_product"."created",COALESCE(SUM("app01_transaction"."total_money"), 0) AS "turnover1", COALESCE(SUM("app01_transactdetails"."quantity"), 0) AS "products_sold1" FROM "app01_product" INNER JOIN "app01_transactdetails" ON ("app01_product"."id" = "app01_transactdetails"."product_id") INNER JOIN "app01_transaction" ON ("app01_transactdetails"."transaction_id" = "app01_transaction"."id") INNER JOIN "app01_transaction_campaigns" ON ("app01_transaction"."id" = "app01_transaction_campaigns"."transaction_id") WHERE "app01_transaction_campaigns"."campaign_id" = %(campaign_id1)s GROUP BY "app01_product"."id") AS A
				left JOIN
			(SELECT "app01_product"."id" AS "id2","app01_product"."name" AS "name2", "app01_product"."description" AS "description2", "app01_product"."price" AS "price2", "app01_product"."tea_base" AS "tea_base2", "app01_product"."item_code" AS "item_code2", "app01_product"."category_id" AS "category_id2", "app01_product"."created" AS "created2",SUM("app01_transaction"."total_money") AS "pre_turnover", SUM("app01_transactdetails"."quantity") AS "pre_products_sold" FROM "app01_product" INNER JOIN "app01_transactdetails" ON ("app01_product"."id" = "app01_transactdetails"."product_id") INNER JOIN "app01_transaction" ON ("app01_transactdetails"."transaction_id" = "app01_transaction"."id") INNER JOIN "app01_transaction_campaigns" ON ("app01_transaction"."id" = "app01_transaction_campaigns"."transaction_id") WHERE "app01_transaction_campaigns"."campaign_id" = %(pre_campaign_id1)s GROUP BY "app01_product"."id") AS B
			ON A.id=B.id2
				inner join app01_category on app01_category.id=A.category_id
	union
		select A.*,B.*,app01_category.name AS category_name from
		(SELECT "app01_product"."id", "app01_product"."name", "app01_product"."description", "app01_product"."price", "app01_product"."tea_base", "app01_product"."item_code", "app01_product"."category_id", "app01_product"."created",COALESCE(SUM("app01_transaction"."total_money"), 0) AS "turnover1", COALESCE(SUM("app01_transactdetails"."quantity"), 0) AS "products_sold1" FROM "app01_product" INNER JOIN "app01_transactdetails" ON ("app01_product"."id" = "app01_transactdetails"."product_id") INNER JOIN "app01_transaction" ON ("app01_transactdetails"."transaction_id" = "app01_transaction"."id") INNER JOIN "app01_transaction_campaigns" ON ("app01_transaction"."id" = "app01_transaction_campaigns"."transaction_id") WHERE "app01_transaction_campaigns"."campaign_id" = %(campaign_id2)s GROUP BY "app01_product"."id") AS A
			right JOIN
		(SELECT "app01_product"."id" AS "id2","app01_product"."name" AS "name2", "app01_product"."description" AS "description2", "app01_product"."price" AS "price2", "app01_product"."tea_base" AS "tea_base2", "app01_product"."item_code" AS "item_code2", "app01_product"."category_id" AS "category_id2", "app01_product"."created" AS "created2",SUM("app01_transaction"."total_money") AS "pre_turnover", SUM("app01_transactdetails"."quantity") AS "pre_products_sold" FROM "app01_product" INNER JOIN "app01_transactdetails" ON ("app01_product"."id" = "app01_transactdetails"."product_id") INNER JOIN "app01_transaction" ON ("app01_transactdetails"."transaction_id" = "app01_transaction"."id") INNER JOIN "app01_transaction_campaigns" ON ("app01_transaction"."id" = "app01_transaction_campaigns"."transaction_id") WHERE "app01_transaction_campaigns"."campaign_id" = %(pre_campaign_id2)s GROUP BY "app01_product"."id") AS B
		ON A.id=B.id2
			inner join app01_category on app01_category.id=A.category_id
	) AS C """

        # filter sql
        filter_sql = ''
        filter_fields_dict = {}
        for filter_field in self.filter_fields:
            filter_field_value = request.GET.get(filter_field)
            if filter_field_value:
                filter_fields_dict[filter_field] = filter_field_value
        if filter_fields_dict:
            filter_sql += ' WHERE '
            for filter_field, filter_field_value in filter_fields_dict.items():
                if filter_sql == ' WHERE ':
                    filter_sql += ' UPPER("{0}") '.format(filter_field) + "LIKE UPPER('%%{0}%%') ".format(
                        filter_field_value)
                else:
                    filter_sql += ' AND UPPER("{0}") '.format(filter_field) + "LIKE UPPER('%%{0}%%') ".format(
                        filter_field_value)
        # search sql
        search_sql = ''
        search_value = request.GET.get('search')
        if search_value:
            if filter_sql == '':
                search_sql += ' WHERE ( '
            else:
                search_sql += ' AND ( '
            for search_field in self.search_fields:
                if search_sql in (' WHERE ( ', ' AND ( '):
                    search_sql += ' UPPER("{0}") '.format(search_field) + "LIKE UPPER('%%{0}%%') ".format(search_value)
                else:
                    search_sql += ' OR UPPER("{0}") '.format(search_field) + "LIKE UPPER('%%{0}%%') ".format(
                        search_value)
            else:
                search_sql += ' ) '
        # where sql(filter sql + search sql)
        where_sql = filter_sql + search_sql
        # Order by products_sold, products_sold_incr, turnover, turnover_incr
        order_sql = ''
        order_field = request.GET.get('ordering')
        desc_order_fields = ['-products_sold', '-products_sold_incr', '-turnover', '-turnover_incr']
        if order_field in self.ordering_fields:
            order_sql = " order by %s " % order_field
        elif order_field in desc_order_fields:
            order_sql = " order by %s desc " % order_field[1:]
        # get page
        page_size, page = get_page(request, self.paginator.page_size)
        limit_sql = ' limit %s offset %s ' % (page_size, (page - 1) * page_size)
        all_sql = sql + where_sql + order_sql + limit_sql
        all_queryset = models.Product.objects.raw(all_sql,
                                                  params={'campaign_id1': campaign.pk, 'campaign_id2': campaign.pk,
                                                          'pre_campaign_id1': pre_campaign_id,
                                                          'pre_campaign_id2': pre_campaign_id})
        all_queryset = list(all_queryset)
        # for i in all_queryset:
        #     print(i.__dict__)
        # Custom queryset
        # 1.remove duplicates
        import copy
        for item in all_queryset:
            item_dict = copy.deepcopy(item.__dict__)
            for field_key, field_value in item_dict.items():
                if not field_key.startswith('_'):
                    if field_key.endswith('2') and field_value:
                        delattr(item, field_key)
                        setattr(item, field_key[:-1], field_value)
        # 2.add product's category
        products = models.Product.objects.select_related('category').all()
        for item in all_queryset:
            for product in products:
                if item.id == product.id:
                    setattr(item, 'category', product.category)
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


class CampaignPerformanceOfOutletViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = (IsAdmin,)
    queryset = models.Outlet.objects.all()
    serializer_class = OutletPerformanceSerializer
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_fields = ['outlet_name', 'outlet_district']
    search_fields = ['outlet_name']
    ordering_fields = ['products_sold', 'products_sold_incr', 'turnover', 'turnover_incr', 'transactions',
                       'transactions_incr']

    def list(self, request, *args, **kwargs):
        # the campaign performance of outlets
        campaign_id = request.GET.get('campaign_id')
        if not campaign_id:
            return Response({'msg': 'Please input campaign_id in url parameters, e.g. http://{url}?campaign_id=1'},
                            status=status.HTTP_403_FORBIDDEN)
        campaign = models.Campaign.objects.filter(pk=campaign_id).filter(pk=campaign_id).first()
        if not campaign:
            return Response({'msg': 'The campaign_id is not exist'}, status=status.HTTP_403_FORBIDDEN)
        # previous campaign
        pre_campaign = models.Campaign.objects.filter(effective_date__lt=campaign.effective_date).order_by(
            '-effective_date').first()
        if not pre_campaign:
            pre_campaign_id = 0
        else:
            pre_campaign_id = pre_campaign.pk
        sql = """select *,COALESCE(turnover1, 0) AS turnover,COALESCE(products_sold1, 0) AS products_sold,COALESCE(transactions1, 0) AS transactions,COALESCE((turnover1-pre_turnover)/pre_turnover, 0) AS turnover_incr,COALESCE((products_sold1-pre_products_sold)/pre_products_sold, 0) AS products_sold_incr,COALESCE((transactions1-pre_transactions)/pre_transactions, 0) AS transactions_incr from
	(select A.*,B.* from
			(SELECT "app01_outlet"."id", "app01_outlet"."outlet_name", "app01_outlet"."outlet_code", "app01_outlet"."outlet_manager", "app01_outlet"."outlet_district", "app01_outlet"."outlet_floor_area", "app01_outlet"."outlet_address",COALESCE(SUM("app01_transaction"."total_money"), 0) AS "turnover1", COALESCE(SUM("app01_transactdetails"."quantity"), 0) AS "products_sold1", COALESCE(COUNT("app01_transaction"."id"), 0) AS "transactions1"
			FROM "app01_outlet"
			INNER JOIN "app01_transaction" ON ("app01_outlet"."id" = "app01_transaction"."outlet_id")
			INNER JOIN "app01_transactdetails" ON ("app01_transaction"."id" = "app01_transactdetails"."transaction_id")
			INNER JOIN "app01_transaction_campaigns" ON ("app01_transaction"."id" = "app01_transaction_campaigns"."transaction_id")
			WHERE "app01_transaction_campaigns"."campaign_id" = %(campaign_id1)s
			GROUP BY "app01_outlet"."id") AS A
		LEFT JOIN
			(SELECT "app01_outlet"."id" AS "id2", "app01_outlet"."outlet_name" AS "outlet_name2", "app01_outlet"."outlet_code" AS "outlet_code2", "app01_outlet"."outlet_manager" AS "outlet_manager2", "app01_outlet"."outlet_district" AS "outlet_district2", "app01_outlet"."outlet_floor_area" AS "outlet_floor_area2", "app01_outlet"."outlet_address" AS "outlet_address2",COALESCE(SUM("app01_transaction"."total_money"), 0) AS "pre_turnover", COALESCE(SUM("app01_transactdetails"."quantity"), 0) AS "pre_products_sold", COALESCE(COUNT("app01_transaction"."id"), 0) AS "pre_transactions"
			FROM "app01_outlet"
			INNER JOIN "app01_transaction" ON ("app01_outlet"."id" = "app01_transaction"."outlet_id")
			INNER JOIN "app01_transactdetails" ON ("app01_transaction"."id" = "app01_transactdetails"."transaction_id")
			INNER JOIN "app01_transaction_campaigns" ON ("app01_transaction"."id" = "app01_transaction_campaigns"."transaction_id")
			WHERE "app01_transaction_campaigns"."campaign_id" = %(pre_campaign_id1)s
			GROUP BY "app01_outlet"."id") AS B
		ON A.id=B.id2) AS C """

        # filter sql
        filter_sql = ''
        filter_fields_dict = {}
        for filter_field in self.filter_fields:
            filter_field_value = request.GET.get(filter_field)
            if filter_field_value:
                filter_fields_dict[filter_field] = filter_field_value
        if filter_fields_dict:
            filter_sql += ' WHERE '
            for filter_field, filter_field_value in filter_fields_dict.items():
                if filter_sql == ' WHERE ':
                    filter_sql += ' UPPER("{0}") '.format(filter_field) + "LIKE UPPER('%%{0}%%') ".format(
                        filter_field_value)
                else:
                    filter_sql += ' AND UPPER("{0}") '.format(filter_field) + "LIKE UPPER('%%{0}%%') ".format(
                        filter_field_value)
        # search sql
        search_sql = ''
        search_value = request.GET.get('search')
        if search_value:
            if filter_sql == '':
                search_sql += ' WHERE ( '
            else:
                search_sql += ' AND ( '
            for search_field in self.search_fields:
                if search_sql in (' WHERE ( ', ' AND ( '):
                    search_sql += ' UPPER("{0}") '.format(search_field) + "LIKE UPPER('%%{0}%%') ".format(search_value)
                else:
                    search_sql += ' OR UPPER("{0}") '.format(search_field) + "LIKE UPPER('%%{0}%%') ".format(
                        search_value)
            else:
                search_sql += ' ) '
        # where sql(filter sql + search sql)
        where_sql = filter_sql + search_sql
        # Order by products_sold, products_sold_incr, turnover, turnover_incr
        order_sql = ''
        order_field = request.GET.get('ordering')
        desc_order_fields = ['-products_sold', '-products_sold_incr', '-turnover', '-turnover_incr']
        if order_field in self.ordering_fields:
            order_sql = " order by %s " % order_field
        elif order_field in desc_order_fields:
            order_sql = " order by %s desc " % order_field[1:]
        # get page
        page_size, page = get_page(request, self.paginator.page_size)
        limit_sql = ' limit %s offset %s ' % (page_size, (page - 1) * page_size)
        all_sql = sql + where_sql + order_sql + limit_sql
        all_queryset = models.Outlet.objects.raw(all_sql,
                                                 {'campaign_id1': campaign.pk, 'campaign_id2': campaign.pk,
                                                  'pre_campaign_id1': pre_campaign_id,
                                                  'pre_campaign_id2': pre_campaign_id})
        all_queryset = list(all_queryset)
        # for i in all_queryset:
        #     print(i.__dict__)
        # Custom queryset
        # 1.remove duplicates
        import copy
        for item in all_queryset:
            item_dict = copy.deepcopy(item.__dict__)
            for field_key, field_value in item_dict.items():
                if not field_key.startswith('_'):
                    if field_key.endswith('2') and field_value:
                        delattr(item, field_key)
                        setattr(item, field_key[:-1], field_value)
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
