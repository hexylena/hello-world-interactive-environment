FROM alpine

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
RUN chmod ugo+r /web/helloworld/index.html

VOLUME ["/import"]
WORKDIR /import/

EXPOSE 80
CMD /startup.sh
