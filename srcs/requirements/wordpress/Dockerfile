FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk add wget \
    php7 php7-fpm php7-mysqli php7-zip php7-gd \
    php7-mbstring php7-cli php7-opcache php7-zlib \
	php7-curl php7-json php7-iconv php7-gettext \
	php7-session php7-phar

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	--output-document=/usr/local/bin/wp-cli && \
    chmod +x /usr/local/bin/wp-cli

RUN mkdir -p /run/php /var/www/html/wordpress

RUN tar -xzf latest.tar.gz -C /var/www/html/wordpress && \
    rm -rf latest.tar.gz

RUN chown -R www-data:www-data /var/www/html/wordpress && \
	chmod 755 /var/www/html/wordpress

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 9000

CMD [ '/run.sh' ]