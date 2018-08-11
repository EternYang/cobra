from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

voucher_router = DefaultRouter()
voucher_router.register('', views.VoucherViewSet)

urlpatterns = [
    path('', include(voucher_router.urls)),
]
