FROM ubuntu:18.04

RUN mkdir /taiga
WORKDIR /taiga

ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y \
                          autoconf flex bison libjpeg-dev \
                          libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev libncurses5-dev \
                          automake libtool curl git tmux gettext \
                          nginx \
                          rabbitmq-server redis-server \
                          python3 python3-pip python3-dev \
                          libxml2-dev libxslt-dev \
                          libssl-dev libffi-dev 
RUN apt install -y nodejs npm

RUN git clone https://github.com/taigaio/taiga-events.git taiga-events
WORKDIR /taiga/taiga-events
RUN npm install && npm install coffe-script
WORKDIR /taiga

RUN git clone --depth=1 https://github.com/taigaio/taiga-back.git taiga-back 
WORKDIR /taiga/taiga-back
RUN pip3 install -r requirements.txt
WORKDIR /taiga

RUN git clone --depth=1 https://github.com/taigaio/taiga-front-dist.git taiga-front

RUN mkdir /cert_gen/
COPY ./gen_cert.sh /cert_gen/gen_cert.sh

RUN mkdir /templates/

COPY ./configs/events/config.json.template /templates/config.json.template
COPY ./configs/frontend/conf.json.template /templates/conf.json.template
COPY ./configs/backend/local.py.template /templates/local.py.template

COPY ./configs/nginx/nginx.conf /etc/nginx/conf.d/nginx.conf

COPY ./entrypoint.sh /entrypoint.sh
CMD /entrypoint.sh