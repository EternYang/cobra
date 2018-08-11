from rest_framework.permissions import BasePermission


class OutletViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'DELETE', 'PUT', 'PATCH',):
            return request.user.role.name in (0, 1, 4)
        else:
            return True
