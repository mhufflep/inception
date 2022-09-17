#!/bin/sh

exec prometheus --config.file=/etc/prometheus/prometheus.yml \
                --storage.tsdb.path /var/lib/prometheus/ \
                --web.console.templates=/usr/share/prometheus/consoles \
                --web.console.libraries=/usr/share/prometheus/console_libraries