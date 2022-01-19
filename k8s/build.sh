#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/images
docker build -f nginx-codalab.Dockerfile . -t nginx-codalab
docker tag nginx-codalab localhost:5000/nginx-codalab
docker push localhost:5000/nginx-codalab

docker build -f django-codalab.Dockerfile . -t django-codalab
docker tag django-codalab localhost:5000/django-codalab
docker push localhost:5000/django-codalab

docker pull postgres:9.6.3
docker tag postgres:9.6.3 localhost:5000/postgres-codalab
docker push localhost:5000/postgres-codalab

docker build -f rabbitmq-codalab.Dockerfile . -t rabbitmq-codalab
docker tag rabbitmq-codalab localhost:5000/rabbitmq-codalab
docker push localhost:5000/rabbitmq-codalab

docker build -f flower-codalab.Dockerfile . -t flower-codalab
docker tag flower-codalab localhost:5000/flower-codalab
docker push localhost:5000/flower-codalab

docker pull memcached:1.6 
docker tag memcached:1.6 localhost:5000/memcached-codalab
docker push localhost:5000/memcached-codalab


docker pull codalab/competitions-v1-compute-worker:1.1.7
docker tag codalab/competitions-v1-compute-worker:1.1.7 localhost:5000/workercompute-codalab
docker push localhost:5000/workercompute-codalab


kubectl create configmap config --from-env-file=./.env --dry-run=client -o yaml > $SCRIPT_DIR/template/config.yaml.template

cd $SCRIPT_DIR
# always generate new config from .env
python3 main.py
