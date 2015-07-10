#!/bin/bash

sed -i "s| '\*'; # IE_CORS_ORIGIN| '${CORS_ORIGIN}';|" /proxy.conf;
cp /proxy.conf /etc/nginx/conf.d/default.conf;

# Correct permissions on the folder
chown $uid:$gid /import -R

cd /import/ && python -mSimpleHTTPServer &
# Launch traffic monitor
/monitor_traffic.sh &
# And nginx in foreground mode.
nginx -g 'daemon off;'
