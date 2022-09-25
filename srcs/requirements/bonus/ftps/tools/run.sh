#!/bin/sh

id "$FTP_USER_NAME" &>/dev/null
if [ $? = 1 ] ; then
    echo "ftps: user does not exist"
    addgroup -S $FTP_USER_NAME
    adduser -D -S $FTP_USER_NAME -G $FTP_USER_NAME
    echo "${FTP_USER_NAME}:${FTP_USER_PASS}" | chpasswd
    chown -R ${FTP_USER_NAME}:${FTP_USER_NAME} /home/${FTP_USER_NAME}/

    cat /vsftpd.conf.tmpl | envsubst > /etc/vsftpd.conf
else
    echo "ftps: user exist"
fi

exec vsftpd /etc/vsftpd.conf $@