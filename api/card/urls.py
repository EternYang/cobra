from django.urls import path, include
from rest_framework.routers import DefaultRouter
from . import views

card_router = DefaultRouter()
card_router.register('', views.CardViewSet)

urlpatterns = [
    path('', include(card_router.urls)),
]
