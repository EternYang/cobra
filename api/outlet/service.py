from utils.utils import transaction_wrapper
from app01 import models
from outlet.serializers import OutletSerializer


@transaction_wrapper
def get_or_create_outlet(initial_data):
    if models.Outlet.objects.filter(outlet_code=initial_data.get('outlet_code')).exists():
        return models.Outlet.objects.get(outlet_code=initial_data.get('outlet_code'))
    serializer = OutletSerializer(data=initial_data)
    serializer.is_valid(raise_exception=True)
    instance = serializer.save()
    return instance
