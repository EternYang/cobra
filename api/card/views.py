from rest_framework import viewsets
from app01 import models
from . import serializers
from utils.pagination import DefaultPagination
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import SearchFilter, OrderingFilter
from .permissions import CardViewSetPermission


class CardViewSet(viewsets.ModelViewSet):
    permission_classes = (CardViewSetPermission,)
    queryset = models.Card.objects.all()
    serializer_class = serializers.CardSerializer
    pagination_class = DefaultPagination
    filter_backends = (
        DjangoFilterBackend,
        SearchFilter,
        OrderingFilter,
    )
    filter_fields = ('card_no', 'member')
    search_fields = ('card_no', 'member')
    ordering_fields = ('card_no', 'member')

    def get_queryset(self):
        ret = super(CardViewSet, self).get_queryset()
        if self.request.user.role.name in (0, 1):
            return ret
        else:
            return ret.filter(member=self.request.user)
