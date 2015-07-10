FROM nginx
MAINTAINER Eric Rasche <esr@tamu.edu>

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
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
RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y \
        locales wget procps nginx python python-pip net-tools && \
    apt-get autoremove -y  && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN dpkg-reconfigure locales


ADD ./startup.sh /startup.sh
ADD ./monitor_traffic.sh /monitor_traffic.sh

# /import will be the universal mount-point for IPython
# The Galaxy instance can copy in data that needs to be present to the IPython webserver
RUN mkdir /import

COPY ./proxy.conf /proxy.conf

RUN chmod +x /startup.sh

VOLUME ["/import"]
WORKDIR /import/
CMD /startup.sh
