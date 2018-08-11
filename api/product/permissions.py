from rest_framework.permissions import BasePermission


class ProductViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'DELETE', 'PUT', 'PATCH',):
            return request.user.role.name in (0, 1, 4)
        else:
            return True


class ToppingsViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'DELETE', 'PUT', 'PATCH',):
            return request.user.role.name in (0, 1, 4)
        else:
            return True


class CategoryViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'DELETE', 'PUT', 'PATCH',):
            return request.user.role.name in (0, 1, 4)
        else:
            return True
