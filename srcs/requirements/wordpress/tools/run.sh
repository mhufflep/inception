#!/bin/bash

# check wordpress folder
if [ ! -e /var/www/html/wordpress/wp-config.php ]; then

    wp-cli config create
		--allow-root
		--dbname=$MYSQL_WP_DB_NAME
		--dbuser=$MYSQL_USER
		--dbpass=$MYSQL_PASSWORD
		--dbhost=$MYSQL_HOST
		--dbprefix=wp
    
	wp-cli core install
		--allow-root
		--url=$DOMAIN_NAME
		--title=$DOMAIN_NAME
		--admin_user=$MYSQL_USER  
		--admin_password=$MYSQL_PASSWORD 
		--admin_email=$WP_ADMIN_EMAIL
    
    wp-cli user create
		$WP_USER_NAME $WP_USER_EMAIL
		--allow-root
		--role=author
		--user_pass=$WP_USER_PASS

	# wp plugin install redis-cache --allow-root --path='/var/www/html/wordpress'
fi

# wp plugin activate redis-cache --allow-root --path='/var/www/html/wordpress'
# wp redis enable --allow-root --path='/var/www/html/wordpress'


php-fpm7.3 --nodaemonize