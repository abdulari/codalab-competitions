FROM python:3.8.3

# For nodejs
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get update && apt-get install -y npm netcat nodejs python-dev libmemcached-dev

RUN pip install --upgrade pip  # make things faster, hopefully

COPY codalab/requirements/common.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./docker /app/docker
COPY ./codalab /app/codalab
COPY ./certs /app/certs
COPY .env /app/.env
RUN chmod +x /app/docker/run_django.sh
RUN chmod +x /app/docker/run_site.sh

WORKDIR /app/codalab