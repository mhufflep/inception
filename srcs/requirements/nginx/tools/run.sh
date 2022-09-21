#!/bin/sh

CONF_PATH='/etc/nginx/http.d/default.conf'

if [ ! -e $CONF_PATH ]; then
    envsubst '$DOMAIN_NAME' < /default.conf > $CONF_PATH
fi

exec nginx -g 'daemon off;' $@