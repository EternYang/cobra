from django.contrib import admin
from django.urls import path, re_path, include
from django.conf.urls import include, url
from django.conf import settings
from django.conf.urls import include, url

urlpatterns = [
    # path('admin/', admin.site.urls),
    re_path('api/(?P<version>\w+)/transaction/', include(('transaction.urls', 'transaction'), namespace='transaction')),
    re_path('api/(?P<version>\w+)/campaign/', include(('campaign.urls', 'campaign'), namespace='campaign')),
    re_path('api/(?P<version>\w+)/membership/', include(('membership.urls', 'membership'), namespace='membership')),
    re_path('api/(?P<version>\w+)/product/', include(('product.urls', 'product'), namespace='product')),
    re_path('api/(?P<version>\w+)/member/', include(('member.urls', 'member'), namespace='member')),
    # re_path('api/(?P<version>\w+)/card/', include(('card.urls', 'card'), namespace='card')),
    re_path('api/(?P<version>\w+)/outlet/', include(('outlet.urls', 'outlet'), namespace='outlet')),
    re_path('api/(?P<version>\w+)/wallet/', include(('wallet.urls', 'wallet'), namespace='wallet')),
    re_path('api/(?P<version>\w+)/voucher/', include(('voucher.urls', 'voucher'), namespace='voucher')),
]

# if settings.DEBUG:
#     import debug_toolbar
#     urlpatterns = [
#                       url(r'^__debug__/', include(debug_toolbar.urls)),
#                   ] + urlpatterns
