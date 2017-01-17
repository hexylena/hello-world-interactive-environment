FROM alpine
MAINTAINER Eric Rasche <esr@tamu.edu>

ENV DEBIAN_FRONTEND=noninteractive \
    DEBUG=false \
    GALAXY_WEB_PORT=10000 \
    NOTEBOOK_PASSWORD=none \
    CORS_ORIGIN=none \
    DOCKER_PORT=none \
    API_KEY=none \
    HISTORY_ID=none \
    REMOTE_HOST=none \
    GALAXY_URL=none

# Ensure cran is available
RUN apk update && \
    apk add \
        wget procps nginx python py2-pip net-tools nginx git patch

ADD ./startup.sh /startup.sh
ADD ./monitor_traffic.sh /monitor_traffic.sh

RUN mkdir -p /import /web/helloworld /run/nginx

COPY ./proxy.conf /proxy.conf
COPY ./index.html /web/helloworld/
COPY ./scroll.patch /web/

VOLUME ["/import"]
WORKDIR /import/

RUN git clone https://github.com/lifenglifeng001/flask-hello /app && \
    cd /app && \
    pip install -r requirements.txt && \
    patch -p1 < /web/scroll.patch


EXPOSE 80
CMD /startup.sh
