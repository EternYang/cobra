from rest_framework.permissions import BasePermission


class MemberViewSetPermission(BasePermission):
    def has_permission(self, request, view):
        if request.method == 'POST':
            return request.user.role.name == 1
        elif request.method == 'DELETE':
            return False
        else:
            return True
