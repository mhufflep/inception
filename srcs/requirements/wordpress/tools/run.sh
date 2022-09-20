#!/bin/sh

wp-cli core download --version=5.8.1

if [ ! -e wp-config.php ]; then
	wp-cli config create             \
		--dbname=$WP_DB_NAME         \
		--dbuser=$MYSQL_USER_NAME    \
		--dbpass=$MYSQL_USER_PASS    \
		--dbhost=$MYSQL_HOST         \
		--dbprefix=wp
fi

if wp-cli core is-installed; then
	echo "Wordpress already installed"
else
	wp-cli core install                  \
		--url=$WP_URL                    \
		--title=$WP_TITLE                \
		--admin_user=$WP_ADMIN_NAME      \
		--admin_password=$WP_ADMIN_PASS  \
		--admin_email=$WP_ADMIN_EMAIL    
		
	wp-cli user create                   \
		$WP_USER_NAME                    \
		$WP_USER_EMAIL                   \
		--role=author                    \
		--user_pass=$WP_USER_PASS        

	wp-cli plugin install redis-cache
fi

wp-cli plugin activate redis-cache
wp-cli redis enable

exec php-fpm7 --nodaemonize $@