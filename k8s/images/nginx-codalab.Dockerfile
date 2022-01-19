FROM nginx
COPY ./docker /app/docker
COPY ./codalab /app/codalab
COPY ./certs /app/certs
COPY .env /app/.env
COPY ./nginx-codalab.entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
RUN chmod +x /app/docker/run_nginx.sh