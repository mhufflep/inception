#!/bin/sh

id "$FTPS_USER_NAME" &>/dev/null
if [ $? = 1 ] ; then
    echo "ftps: user does not exist"
    addgroup -S $FTPS_USER_NAME
    adduser -D -S $FTPS_USER_NAME -G $FTPS_USER_NAME
    echo "${FTPS_USER_NAME}:${FTPS_USER_PASS}" | chpasswd
else
    echo "ftps: user exist"
fi

exec vsftpd /etc/vsftpd.conf $@