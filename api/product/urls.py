from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register('toppings', views.ToppingsViewSet, base_name='toppings')
router.register('category', views.CategoryViewSet, base_name='category')
router.register('tea-base', views.ProductTeaBaseViewSet, base_name='tea_base')
router.register('', views.ProductViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
