#!/bin/sh

if [ ! -e /etc/redis.conf ]; then
    cat /redis.conf.tmpl | envsubst > /etc/redis.conf
fi

exec redis-server /etc/redis.conf $@