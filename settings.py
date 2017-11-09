import os


INSTALLED_APPS = []
TEMPLATES = []
STATICFILES_DIRS = []

INSTALLED_ADDONS = [
    # <INSTALLED_ADDONS>  # Warning: text inside the INSTALLED_ADDONS tags is auto-generated. Manual changes will be overwritten.
    'aldryn-addons',
    'aldryn-django',
    'aldryn-sso',
    # </INSTALLED_ADDONS>
]

import aldryn_addons.settings  # NOQA
aldryn_addons.settings.load(locals())


# all django settings can be altered here

INSTALLED_APPS.extend([
    # Third party apps
    'celeryapp',
    'django_celery_results',
])

CELERY_BROKER_URL = os.environ.get('CELERY_BROKER_URL', None)
CELERY_RESULT_BACKEND = 'django-db'
