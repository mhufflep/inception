#!/bin/sh

# id "$MYSQL_USER_NAME" &>/dev/null
# if [ $? = 1 ] ; then
#     echo "mysql: user does not exist"
#     addgroup -S $MYSQL_USER_NAME
#     adduser -S $MYSQL_USER_NAME -G $MYSQL_USER_NAME --shell /bin/sh
#     echo "${MYSQL_USER_NAME}:${MYSQL_USER_PASS}" | chpasswd
# else
#     echo "mysql: user exist"
# fi

SQL_FILE='mysql-init.sql'

# Installing db
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Creating db for wordpress
echo "" > ${SQL_FILE}
echo "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;" >> ${SQL_FILE}
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER_NAME'@'%' IDENTIFIED BY '$MYSQL_USER_PASS';" >> ${SQL_FILE}
echo "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$MYSQL_USER_NAME'@'%' WITH GRANT OPTION;" >> ${SQL_FILE}

# Changing root password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS" >> ${SQL_FILE}
echo "FLUSH PRIVILEGES;" >> ${SQL_FILE}

# Running daemon
exec mysqld --default-file='/confs/my.cnf' --init-file=${SQL_FILE}
