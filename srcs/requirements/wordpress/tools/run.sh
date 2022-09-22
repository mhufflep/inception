#!/bin/sh

set -x

if [ ! -e wp-config.php ]; then
	wp config create --allow-root \
		--dbname=$WP_DB_NAME      \
		--dbuser=$MYSQL_USER_NAME \
		--dbpass=$MYSQL_USER_PASS \
		--dbhost=$MYSQL_HOST

	wp db create --allow-root
fi

if wp core is-installed --allow-root; then
	echo "Wordpress core already installed"
else
	wp core install --allow-root \
		--url=$WP_URL     \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_NAME   \
		--admin_email=$WP_ADMIN_EMAIL \
		--admin_password=$WP_ADMIN_PASS
		
	wp user create --allow-root \
		$WP_USER_NAME  \
		$WP_USER_EMAIL \
		--role=author  \
		--user_pass=$WP_USER_PASS        

	wp plugin install redis-cache --allow-root

	wp config set WP_DEBUG false --allow-root
	wp config set WP_REDIS_HOST $REDIS_HOST --add --allow-root
	wp config set WP_REDIS_PORT $REDIS_PORT --add --allow-root
fi

wp plugin activate redis-cache --allow-root
wp plugin update --all --allow-root
wp redis enable --allow-root

exec php-fpm7 --nodaemonize $@