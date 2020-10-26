#!/bin/sh
cd /taiga/taiga-back

if [ -f "/locks/db_setup.lock" ]; then
    python3 ./manage.py migrate --noinput
    python3 ./manage.py loaddata initial_user
    python3 ./manage.py loaddata initial_project_templates
    python3 ./manage.py compilemessages
    python3 ./manage.py collectstatic --noinput

    rm /locks/db_setup.lock
fi

cd /taiga/taiga-back/ && PYTHONUNBUFFERED=true gunicorn --workers 4 --timeout 60 -b 0.0.0.0:8001 taiga.wsgi --log-level debug &
cd /taiga/taiga-events/ && node_modules/coffeescript/bin/coffee index.coffee &

nginx -g 'daemon off;' 
