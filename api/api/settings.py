import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/dev/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '(yz$4vzbf=smc__)c@5rz*r78zql2!-a=xt3m+9w_4app)6beb'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = [
    # 'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    # 'django.contrib.messages',
    'django.contrib.staticfiles',
    'corsheaders',
    'django_filters',
    'rest_framework',
    'django_crontab',
    'app01',  # database
    'wallet',  # signals
    # 'debug_toolbar',
    # 'pympler',
]

# CACHES = {
#     "default": {
#         "BACKEND": "django_redis.cache.RedisCache",
#         "LOCATION": "redis://127.0.0.1:6379/1",
#         "OPTIONS": {
#             "CLIENT_CLASS": "django_redis.client.DefaultClient",
#             # "PASSWORD": "mysecret"
#         }
#     }
# }
# SESSION_ENGINE = "django.contrib.sessions.backends.cache"
# SESSION_CACHE_ALIAS = "default"
# CACHE_MIDDLEWARE_SECONDS = 100

# CACHES = {
#     'default': {
#         'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
#         'LOCATION': 'unique-snowflake',
#         'TIMEOUT': 300,  # Cache timeout (default 300, None means never expires, 0 means expires immediately)
#         'OPTIONS': {
#             'MAX_ENTRIES': 300,  # Maximum number of caches (default 300)
#             'CULL_FREQUENCY': 3,
#             # After the maximum number of caches reaches, the ratio of the number of caches is removed, namely: 1/CULL_FREQUENCY (default 3)
#         }
#     }
# }

MIDDLEWARE = [

    # 'django.middleware.cache.UpdateCacheMiddleware',
    'utils.middleware.BlockedIpMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    # 'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    # 'django.contrib.messages.middleware.MessageMiddleware',
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
    # 'django.middleware.cache.FetchFromCacheMiddleware',
    # 'debug_toolbar.middleware.DebugToolbarMiddleware',

]

# INTERNAL_IPS = ['127.0.0.1']
# DEBUG_TOOLBAR_CONFIG = {
#     'JQUERY_URL': "http://code.jquery.com/jquery-2.1.1.min.js",
# }
# DEBUG_TOOLBAR_PANELS = (
#     'debug_toolbar.panels.versions.VersionsPanel',
#     'debug_toolbar.panels.timer.TimerPanel',
#     'debug_toolbar.panels.settings.SettingsPanel',
#     'debug_toolbar.panels.headers.HeadersPanel',
#     'debug_toolbar.panels.request.RequestPanel',
#     'debug_toolbar.panels.sql.SQLPanel',
#     'debug_toolbar.panels.staticfiles.StaticFilesPanel',
#     'debug_toolbar.panels.templates.TemplatesPanel',
#     'debug_toolbar.panels.cache.CachePanel',
#     'debug_toolbar.panels.signals.SignalsPanel',
#     'debug_toolbar.panels.logging.LoggingPanel',
#     'debug_toolbar.panels.redirects.RedirectsPanel',
#     'pympler.panels.MemoryPanel',
# )

# CRON_CLASSES = [
#     "member.cron.MyCronJob",
# ]

CRONJOBS = [
    ('2 0 * * *', 'member.cron.daily', '>>/home/pyprojects/cobra/api/member_cron.log'),
    ('2 0 1 * *', 'member.cron.monthly', '>>/home/pyprojects/cobra/api/member_cron.log'),
]

# 跨域忽略
# CORS_ALLOW_CREDENTIALS = False
CORS_ORIGIN_ALLOW_ALL = True

ROOT_URLCONF = 'api.urls'

TEMPLATES = [
    # {
    #     'BACKEND': 'django.template.backends.django.DjangoTemplates',
    #     'DIRS': [],
    #     'APP_DIRS': True,
    #     'OPTIONS': {
    #         'context_processors': [
    #             'django.template.context_processors.debug',
    #             'django.template.context_processors.request',
    #             'django.contrib.auth.context_processors.auth',
    #             'django.contrib.messages.context_processors.messages',
    #         ],
    #     },
    # },
]

WSGI_APPLICATION = 'api.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'cobra_db',
        'USER': 'cobra_user',
        'PASSWORD': '123',
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}

# Password validation
# https://docs.djangoproject.com/en/dev/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    # {
    #     'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    # },
    # {
    #     'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    # },
    # {
    #     'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    # },
    # {
    #     'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    # },
]

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
        },
    },
    'loggers': {
        'django.db.backends': {
            'handlers': ['console'],
            'level': 'DEBUG' if DEBUG else 'INFO',
        },
    },
}

# LOGGING = {
#     'version': 1,
#     'disable_existing_loggers': True,
#     'formatters': {
#         'verbose': {
#             'format': '[%(asctime)s] %(levelname)s [%(name)s.%(funcName)s:%(lineno)d] %(message)s',
#             'datefmt': '%Y-%m-%d %H:%M:%S'
#         },
#     },
#     'handlers': {
#         'console': {
#             'level': 'DEBUG',
#             'class': 'logging.StreamHandler',
#             'formatter': 'verbose'
#         },
#         'logfile': {
#             'level': 'DEBUG',
#             'class': 'logging.handlers.RotatingFileHandler',
#             'filename': 'cobra.log',
#             'maxBytes': 1024 * 1024 * 5,  # 5 MB
#             'backupCount': 7,
#             'formatter': 'verbose'
#         },
#     },
#     'loggers': {
#         'django.db.backends': {
#             'level': 'ERROR',
#             'handlers': ['console', 'logfile'],
#             'propagate': False,
#         },
#         'django': {
#             'handlers': ['console', 'logfile'],
#             'propagate': False,
#             'level': 'DEBUG',
#         },
#     }
# }


# Internationalization
# https://docs.djangoproject.com/en/dev/topics/i18n/

LANGUAGE_CODE = 'en-us'

# TIME_ZONE = 'Asia/Shanghai'
TIME_ZONE = 'Asia/Singapore'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/dev/howto/static-files/

STATIC_URL = '/static/'

AUTH_USER_MODEL = "app01.Member"  # for rest_framework.authtoken.models.Token


# ##################### Global configuration rest_framework ########################
REST_FRAMEWORK = {
    "DEFAULT_VERSIONING_CLASS": "rest_framework.versioning.URLPathVersioning",
    "VERSION_PARAM": "version",
    "DEFAULT_VERSION": "v1",
    "ALLOWED_VERSIONS": ["v1", "v2"],
    "UNAUTHENTICATED_USER": None,
    "UNAUTHENTICATED_TOKEN": None,
    'DEFAULT_PAGINATION_CLASS': 'utils.pagination.DefaultPagination',
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'utils.auth.CustomAuthentication',
    ),
    'DEFAULT_FILTER_BACKENDS': (
        'django_filters.rest_framework.DjangoFilterBackend',
    ),
    "DEFAULT_PERMISSION_CLASSES": (
        "rest_framework.permissions.IsAuthenticated",
    ),
    # "DEFAULT_THROTTLE_RATES": {
    #     "anon": "5/m",
    #     "user": "10/m",
    # },
    'DEFAULT_PARSER_CLASSES': (
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser',
    ),
    'DEFAULT_RENDERER_CLASSES': (
        'rest_framework.renderers.JSONRenderer',
    )
}
# from rest_framework.parsers
# ##################### Business logic configuration ########################
# Member can get bonus points by binding emails
BINDING_EMAIL = {
    'reward_points': 3
}

# Supplementary Information Bonus Points
SUPPLEMENT_INFO = {
    'reward_points': 3
}

# # ########## Initialization data
# # Initialize points reward rules data
# INIT_POINTS_INFO_LIST = [
#     {
#         "name": "Default member's supplementary information points reward",
#         "description": "Default member's supplementary information points reward",
#         "obtain_type": 3,
#         "effective_date": "2000-01-01T00:00:00",
#         "expiring_date": "2099-01-01T00:00:00",
#         "bonus_points": BONUS_POINTS,
#     }
# ]

# ################# IP Black LIST ###############
BLOCKED_IPS = ('111.231.105.60', '111.231.215.222', '198.23.206.98',)
