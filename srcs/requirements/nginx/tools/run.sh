#!/bin/sh

CONF_PATH = /etc/nginx/sites-available/default.conf

envsubst '$DOMAIN_NAME' < $CONF_PATH > $CONF_PATH

exec nginx -g 'daemon off;'