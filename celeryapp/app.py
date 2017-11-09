import os

from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'settings')
os.environ['C_FORCE_ROOT'] = 'true'

app = Celery('primerbench')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()
