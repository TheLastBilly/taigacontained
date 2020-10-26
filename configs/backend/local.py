from .common import *

MEDIA_URL = "http://localhost/media/"
STATIC_URL = "http://localhost/static/"
SITES["front"]["scheme"] = "http"
SITES["front"]["domain"] = "localhost"

SECRET_KEY = "4/oHmHdCY5j0Va4XNfei+1LIScV+JW4WNpHDTr5XXkI="

DEBUG = False
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "no-reply@example.com"
SERVER_EMAIL = DEFAULT_FROM_EMAIL

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "taiga",
        "HOST": "db",
        "USER": "taiga",
        "PASSWORD": "Tragedy0-Jawed-Applicant"
    }
}

#CELERY_ENABLED = True

EVENTS_PUSH_BACKEND = "taiga.events.backends.rabbitmq.EventsPushBackend"
EVENTS_PUSH_BACKEND_OPTIONS = {"url": "amqp://taiga:Tragedy0-Jawed-Applicant@rabiit:5672/taiga"}

# Uncomment and populate with proper connection parameters
# to enable email sending. `EMAIL_HOST_USER` should end by @<domain>.<tld>
#EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
#EMAIL_USE_TLS = False
#EMAIL_HOST = "localhost"
#EMAIL_HOST_USER = ""
#EMAIL_HOST_PASSWORD = ""
#EMAIL_PORT = 25

# Uncomment and populate with proper connection parameters
# to enable GitHub login/sign-in.
#GITHUB_API_CLIENT_ID = "yourgithubclientid"
#GITHUB_API_CLIENT_SECRET = "yourgithubclientsecret"