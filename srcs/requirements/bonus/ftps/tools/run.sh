#!/bin/sh

echo "${FTP_USER_NAME}:${FTP_USER_PASS}" | chpasswd

exec vsftpd /etc/vsftpd.conf