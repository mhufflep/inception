#!/bin/bash

# Installing db
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Creating db for wordpress
echo "" > mysql-init.sql
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_WP_DB_NAME;" >> mysql-init.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> mysql-init.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_WP_DB_NAME.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;" >> mysql-init.sql

# Changing root password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD" >> mysql-init.sql
echo "FLUSH PRIVILEGES;" >> mysql-init.sql

# Running daemon
mysqld --default-file='/configurations/my.cnf' --datadir='/var/lib/mysql' --init-file 'mysql-init.sql'
