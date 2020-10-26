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

COPY ./configs/events/config.json /taiga/taiga-events/config.json
COPY ./configs/frontend/conf.json /taiga/taiga-front/dist/conf.json
COPY ./configs/backend/local.py /taiga/taiga-back/settings/local.py
COPY ./configs/nginx/nginx.conf /etc/nginx/conf.d/nginx.conf

COPY ./entrypoint.sh /entrypoint.sh
CMD /entrypoint.sh