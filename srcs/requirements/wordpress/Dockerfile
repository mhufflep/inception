FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install wget php7.3 php-mysql php7.3-fpm php-pdo php-gd php-cli php-mbstring

RUN mkdir -p /var/www/html/wordpress && \
	mkdir -p /run/php

RUN chown -R www-data:www-data /var/www/html/wordpress && \
	chmod 755 /var/www/html/wordpress

RUN wget https://wordpress.org/wordpress-5.8.1.tar.gz && \
	tar -xzf wordpress-5.8.1.tar.gz -C /var/www/html/ && \
	rm -f wordpress-5.8.1.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp-cli
    
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY ./tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5050

CMD ["/start.sh"]