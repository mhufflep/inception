#!/bin/sh

set -x

if [ ! -e wp-config.php ]; then
	wp config create --allow-root \
		--dbname=$WP_DB_NAME      \
		--dbuser=$MYSQL_USER_NAME \
		--dbpass=$MYSQL_USER_PASS \
		--dbhost=$MYSQL_HOST

	wp db create
fi

if wp core is-installed; then
	echo "Wordpress core already installed"
else
	wp core install       \
		--url=$WP_URL     \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_NAME   \
		--admin_email=$WP_ADMIN_EMAIL \
		--admin_password=$WP_ADMIN_PASS
		
	wp user create     \
		$WP_USER_NAME  \
		$WP_USER_EMAIL \
		--role=author  \
		--user_pass=$WP_USER_PASS        

	wp plugin install redis-cache

fi

wp plugin activate redis-cache
wp plugin update --all
wp redis enable

wp config set WP_REDIS_HOST $REDIS_HOST --add
wp config set WP_REDIS_PORT $REDIS_PORT --add

exec php-fpm7 --nodaemonize $@