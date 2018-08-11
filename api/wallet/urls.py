from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()

router.register('recharge-record', views.RechargeRecordViewSet, base_name='recharge_record')
router.register('wallet-amt-dis', views.WalletAmtDisView, base_name='wallet_amt_dis')
router.register('', views.WalletViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
