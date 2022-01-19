FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y wget git \
    python3.8 python3-pip \
    python3-dev netcat libmemcached-dev libpq-dev
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt install -y build-essential libxml2-dev libxslt-dev

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NVM_VERSION 0.37.2
ENV NODE_VERSION 16.13.2

# install node via nvm
RUN mkdir -p ${NVM_DIR} \
    && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . ${NVM_DIR}/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION}

# add node and npm to path so the commands are available
ENV NODE_PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/lib/node_modules
ENV PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:$PATH

# codalab stuffs
COPY codalab /app/codalab
WORKDIR /app/codalab
RUN npm install .
RUN npm install -g less
RUN npm run build-css

RUN pip install -r requirements/common.txt

RUN apt-get -y autoclean
COPY run_django.sh .
RUN chmod +x run_django.sh
