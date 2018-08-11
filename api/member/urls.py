from django.urls import path, include, re_path
from rest_framework.routers import DefaultRouter
from . import views

member_router = DefaultRouter()
member_router.register('', views.MemberViewSet)

urlpatterns = [
    path('login/', views.LoginView.as_view(), name="login"),
    path('register/', views.RegisterView.as_view(), name="register"),
    re_path('card/', include('card.urls')),
    path('', include(member_router.urls)),
]
