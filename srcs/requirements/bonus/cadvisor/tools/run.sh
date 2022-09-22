#!/bin/sh

exec /usr/bin/cadvisor -logtostderr -port=$CADVISOR_PORT $@