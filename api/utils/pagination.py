from rest_framework.pagination import PageNumberPagination
# from django.utils.functional import cached_property
# from django.core.paginator import Paginator as DjangoPaginator


class DefaultPagination(PageNumberPagination):
    page_size = 10  # 默认每页显示的数据条数
    page_query_param = 'page'  # 第几页
    page_size_query_param = 'page_size'  # 设置每页显示的数据条数


# class CustomerPaginator(DjangoPaginator):
#     @cached_property
#     def count(self):
#         """Return the total number of objects, across all pages."""
#         return self.object_list.c_count


# class CustomerPagination(DefaultPagination):
#     django_paginator_class = CustomerPaginator
