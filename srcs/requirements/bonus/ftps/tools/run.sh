#!/bin/sh

mkdir -p /etc/ssl/certs
mkdir -p /etc/ssl/private

cp ${CRT_PATH} /etc/ssl/certs/vsftpd.crt
cp ${KEY_PATH} /etc/ssl/private/vsftpd.key

vsftpd /etc/vsftpd.conf