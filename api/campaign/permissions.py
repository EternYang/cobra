from rest_framework.permissions import BasePermission


class CampaignViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method == 'POST':
            return request.user.role.name == 0
        elif request.method == 'DELETE':
            return request.user.role.name == 0
        elif request.method == 'PUT':
            return request.user.role.name == 0
        elif request.method == 'PATCH':
            return request.user.role.name == 0
        else:
            return True
