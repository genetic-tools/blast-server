from django.apps import AppConfig


class CeleryConfig(AppConfig):
    name = 'celeryapp'
    verbose_name = 'Celery'

    def ready(self):
        from .app import app  # NOQA
