FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

ARG	WORDPRESS_VERSION=5.8.1

RUN apk update && apk upgrade
RUN apk add --no-cache wget \
    php7 php7-fpm php7-mysqli php7-zip php7-gd \
    php7-mbstring php7-cli php7-opcache php7-zlib \
	php7-curl php7-json php7-iconv php7-gettext \
	php7-session php7-phar mariadb-client php7-pdo php7-pdo_mysql 

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	--output-document=/usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php /var/www/html/wordpress
RUN chmod -R 755 /var/www/html/wordpress

RUN addgroup -S wps && adduser -S wps -G wps
COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf
WORKDIR /var/www/html/wordpress

RUN wp core download --version=$WORDPRESS_VERSION

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 9000

ENTRYPOINT [ "/run.sh" ]