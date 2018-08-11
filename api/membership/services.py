from app01 import models


def get_initial_membership_level():
    return models.Membership.objects.order_by('start_points').first()
