from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register('transact-details', views.TransactDetailsViewSet, base_name='transact_details')
router.register('sales_record', views.SalesRecordViewSet, base_name='sales_record')
router.register('evaluation', views.EvaluationViewSet, base_name='evaluation')
router.register('', views.TransactionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
