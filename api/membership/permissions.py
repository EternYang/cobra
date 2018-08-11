from rest_framework.permissions import BasePermission


class MembershipViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method in ('POST', 'DELETE', 'PUT', 'PATCH',):
            return request.user.role.name == 0
        else:
            return True
