from rest_framework.permissions import BasePermission


class TransactionAndTransactDetailsViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'DELETE', 'PUT', 'PATCH'):
            return request.user.role.name in (0, 1, 4)
        else:
            return True


class EvaluationViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('DELETE', 'PUT', 'PATCH'):
            return request.user.role.name in (0, 1, 4)
        else:
            return True
