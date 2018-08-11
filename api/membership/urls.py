from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

membership_router = DefaultRouter()
membership_router.register('', views.MembershipViewSet)

urlpatterns = [
    path('', include(membership_router.urls)),
]
