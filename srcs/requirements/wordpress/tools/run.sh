#!/bin/sh

if wp-cli core is-installed; then
	echo "Wordpress already installed"
else

	if [ ! -e wp-config.php ]; then
		wp-cli config create             \
			--dbname=$WP_DB_NAME         \
			--dbuser=$MYSQL_USER_NAME    \
			--dbpass=$MYSQL_USER_PASS    \
			--dbhost=$MYSQL_HOST         \
			--dbprefix=wp
	fi

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
	wp-cli plugin activate redis-cache
	wp-cli redis enable	
fi

exec php-fpm7.3 --nodaemonize