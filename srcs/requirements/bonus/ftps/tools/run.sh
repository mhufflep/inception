#!/bin/sh

# Add configuration

mkdir -p /etc/ssl/private

# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

vsftpd /etc/vsftpd.conf