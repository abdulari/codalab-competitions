#!/bin/sh
cd /app/codalab
python3 manage.py collectstatic --noinput
python3 manage.py migrate
python3 manage.py loaddata initial_data.json initial_team_data.json
PYTHONUNBUFFERED=TRUE gunicorn codalab.wsgi \
    --reload \
    --timeout 4096 \
    --enable-stdio-inheritance