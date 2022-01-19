FROM rabbitmq:3.8-management

RUN apt-get update && apt-get install -y gettext
COPY ./docker /app/docker
COPY ./certs /app/certs
COPY .env /app/.env
RUN chmod +x /app/docker/run_rabbitmq.sh