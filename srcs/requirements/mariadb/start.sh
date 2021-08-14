#openrc default
#/etc/init.d/mariadb setup

#rc-service mariadb start

#mysql < create.sql 

#mysql wordpress -u root < /server/wordpress.sql

/usr/bin/mysqld_safe --datadir='/var/lib/mysql'
#rc-service mariadb stop
