#!/bin/sh

mkdir -p /etc/ssl/certs
mkdir -p /etc/ssl/private

cp ${CRT_PATH} /etc/ssl/certs/server.crt
cp ${KEY_PATH} /etc/ssl/private/server.key

nginx -g 'daemon off;'