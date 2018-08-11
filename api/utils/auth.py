from rest_framework import authentication
from app01 import models
from django.utils.six import text_type
from rest_framework import HTTP_HEADER_ENCODING, exceptions
from django.utils.translation import ugettext_lazy as _


class CustomAuthentication(authentication.TokenAuthentication):
    model = models.Token

    def authenticate(self, request):
        auth = request.META.get('HTTP_AUTHORIZATION', b'')
        if isinstance(auth, text_type):
            # Work around django test client oddness
            auth = auth.encode(HTTP_HEADER_ENCODING)
        auth = auth.split()
        if not auth or auth[0].lower() != self.keyword.lower().encode():
            msg = _(
                "Invalid token header. Clients should authenticate by passing the token key in the 'Authorization' HTTP header, prepended with the string 'Token '.")
            raise exceptions.AuthenticationFailed(msg)

        if len(auth) == 1:
            msg = _('Invalid token header. No credentials provided.')
            raise exceptions.AuthenticationFailed(msg)
        elif len(auth) > 2:
            msg = _('Invalid token header. Token string should not contain spaces.')
            raise exceptions.AuthenticationFailed(msg)

        try:
            token = auth[1].decode()
        except UnicodeError:
            msg = _('Invalid token header. Token string should not contain invalid characters.')
            raise exceptions.AuthenticationFailed(msg)
        return self.authenticate_credentials(token)

    def authenticate_credentials(self, key):
        model = self.get_model()
        try:
            token = model.objects.select_related('user').get(key=key)
        except model.DoesNotExist:
            raise exceptions.AuthenticationFailed('Invalid token.')
        return (token.user, token)
