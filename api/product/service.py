from .serializers import ProductCUDSerializer, CategorySerializer, ToppingsSerializer
from utils.utils import transaction_wrapper
from app01 import models


@transaction_wrapper
def get_or_create_product(initial_data):
    if models.Product.objects.filter(item_code=initial_data.get('item_code')).exists():
        return models.Product.objects.get(item_code=initial_data.get('item_code'))
    category_data = initial_data.pop('category')
    if models.Category.objects.filter(category_code=category_data.get('category_code')).exists():
        category = models.Category.objects.get(category_code=category_data.get('category_code'))
    else:
        serializer = CategorySerializer(data=category_data)
        serializer.is_valid(raise_exception=True)
        category = serializer.save()
    initial_data['category'] = category.pk
    serializer = ProductCUDSerializer(data=initial_data)
    serializer.is_valid(raise_exception=True)
    instance = serializer.save()
    return instance


@transaction_wrapper
def get_or_create_toppings(initial_data):
    if models.Toppings.objects.filter(name=initial_data.get('name')).exists():
        return models.Toppings.objects.get(name=initial_data.get('name'))
    serializer = ToppingsSerializer(data=initial_data)
    serializer.is_valid(raise_exception=True)
    instance = serializer.save()
    return instance
