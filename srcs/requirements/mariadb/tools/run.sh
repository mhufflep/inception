#!/bin/sh

SQL_FILE='init.sql'

# Installing db
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Creating db for wordpress
envsubst < tmpl.sql > ${SQL_FILE}
mysql -u root < ${SQL_FILE}

# Running daemon
exec mysqld_safe --user=mysql --datadir="/var/lib/mysql" --port=3306 $@
