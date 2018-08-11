from rest_framework.permissions import BasePermission


class RechargeRecordViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method == 'POST':
            return request.user.role.name in (1, 4)
        else:
            return True


class WalletViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('PUT', 'PATCH'):
            return request.user.role.name in (1, 4)
        else:
            return True
