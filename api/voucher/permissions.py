from rest_framework.permissions import BasePermission


class VoucherViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method == 'POST' or request.method == 'DELETE' or request.method == 'PUT' or request.method == 'PATCH':
            return request.user.role.name == 0
        else:
            return True
