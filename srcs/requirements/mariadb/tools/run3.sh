#!/bin/sh

SQL_FILE='/init.sql'

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Installing db
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

fi
# Creating db for wordpress
cat tmpl.sql | envsubst > ${SQL_FILE}

# Running daemon
exec mysqld --user=mysql --datadir="/var/lib/mysql" --port=3306 --init-file ${SQL_FILE} $@
