#!/bin/sh

CONF_PATH='/etc/nginx/http.d/default.conf'

if [ ! -e $CONF_PATH ]; then
    cat /default.conf.tmpl | envsubst '$NGINX_PORT $DOMAIN_NAME $CRT_PATH $KEY_PATH $PV_WP_MOUNT_PATH $PV_CV_MOUNT_PATH $ADMINER_PORT $WORDPRESS_PORT $PROMETHEUS_PORT $CADVISOR_PORT' > $CONF_PATH
fi

exec nginx -g 'daemon off;' $@