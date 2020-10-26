#!/bin/sh

envsubst < "/templates/config.json.template" > "/taiga/taiga-events/config.json"
envsubst < "/templates/conf.json.template" > "/taiga/taiga-front/dist/conf.json"
envsubst < "/templates/local.py.template" > "/taiga/taiga-back/settings/local.py"

if [ -f "/locks/certs_setup.lock" ]; then
    cd /cert_gen/
    
    ./gen_cert.sh
    cat cert.crt > /certs/cert.crt
    cat cert.key > /certs/cert.key
    rm 
    cd /

    mv /locks/certs_setup.lock /locks/.certs_setup.lock
fi

if [ -f "/locks/db_setup.lock" ]; then
    cd /taiga/taiga-back
    
    python3 ./manage.py migrate --noinput
    python3 ./manage.py loaddata initial_user
    python3 ./manage.py loaddata initial_project_templates
    python3 ./manage.py compilemessages
    python3 ./manage.py collectstatic --noinput

    mv /locks/db_setup.lock /locks/.db_setup.lock
fi

cd /taiga/taiga-back/
PYTHONUNBUFFERED=true gunicorn --workers 4 --timeout 60 -b 0.0.0.0:8001 taiga.wsgi --log-level debug &

cd /taiga/taiga-events/
node_modules/coffeescript/bin/coffee index.coffee &

nginx -g 'daemon off;' 