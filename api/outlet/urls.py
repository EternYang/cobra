from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register('outlet-name', views.OutletNameViewSet, base_name='outlet_name')
router.register('outlet-district', views.OutletDistrictViewSet, base_name='outlet_district')
router.register('', views.OutletViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
