#!/bin/sh

if [ ! -e /etc/prometheus/prometheus.yml ]; then
   cat /prometheus.yml.tmpl | envsubst > /etc/prometheus/prometheus.yml
fi

exec prometheus --config.file=/etc/prometheus/prometheus.yml \
                --storage.tsdb.path=/monitor/prometheus/ \
                --web.console.templates=/usr/share/prometheus/consoles \
                --web.console.libraries=/usr/share/prometheus/console_libraries $@