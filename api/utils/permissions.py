from rest_framework.permissions import BasePermission


class IsApp(BasePermission):
    def has_permission(self, request, view):
        return request.user.role.name == 4


class IsAdmin(BasePermission):
    def has_permission(self, request, view):
        return request.user.role.name == 0


class IsAdminOrPos(BasePermission):
    def has_permission(self, request, view):
        return request.user.role.name == 0 or request.user.role.name == 1


class IsPos(BasePermission):
    def has_permission(self, request, view):
        return request.user.role.name == 1


class IsMember(BasePermission):
    def has_permission(self, request, view):
        return request.user.role.name == 2


class IsAnonymous(BasePermission):
    def has_permission(self, request, view):
        return request.user.role.name == 3
