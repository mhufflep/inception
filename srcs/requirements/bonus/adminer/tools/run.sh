#!/bin/sh

if [ ! -e /etc/php7/php-fpm.d/www.conf ]; then
    cat /www.conf.tmpl | envsubst > /etc/php7/php-fpm.d/www.conf
fi

exec php-fpm7 --nodaemonize $@