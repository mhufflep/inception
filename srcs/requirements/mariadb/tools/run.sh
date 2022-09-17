#!/bin/sh

SQL_FILE = 'mysql-init.sql'

# Installing db
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Creating db for wordpress
echo "" > ${SQL_FILE}
echo "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;" >> ${SQL_FILE}
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> ${SQL_FILE}
echo "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" >> ${SQL_FILE}

# Changing root password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD" >> ${SQL_FILE}
echo "FLUSH PRIVILEGES;" >> ${SQL_FILE}

# Running daemon
exec mysqld --default-file='/confs/my.cnf' --datadir='/var/lib/mysql' --init-file ${SQL_FILE}
