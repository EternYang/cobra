from rest_framework.permissions import BasePermission


class CardViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'PATCH', 'PUT'):
            return request.user.role.name == 1
        elif request.method == 'DELETE':
            return False
        else:
            return True
