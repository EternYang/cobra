from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()

router.register('campaign-type', views.CampaignTypeViewSet, base_name='campaign_type')
router.register('campaign-condition', views.CampaignConditionViewSet, base_name='campaign_condition')
router.register('occupation', views.OccupationViewSet, base_name='occupation')
router.register('performance-product', views.CampaignPerformanceOfProductViewSet, base_name='performance_product')
router.register('performance-outlet', views.CampaignPerformanceOfOutletViewSet, base_name='performance_outlet')
router.register('', views.CampaignViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
