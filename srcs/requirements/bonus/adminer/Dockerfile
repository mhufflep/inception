FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="16-Sep-2022"

ARG	ADMINER_VERSION=4.8.1
ARG ADMINER_FOLDER=/var/www/html/adminer

RUN apk update && apk upgrade
RUN	apk add --no-cache wget gettext \
    php7 php7-fpm php7-mysqli php7-zip php7-gd \
    php7-mbstring php7-cli php7-opcache php7-zlib \
	php7-curl php7-json php7-iconv php7-gettext \
	php7-session php7-phar mariadb-client php7-pdo php7-pdo_mysql 

RUN mkdir -p "$ADMINER_FOLDER" /run/php

RUN wget "https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php" \
	--output-document="$ADMINER_FOLDER/adminer.php"

RUN addgroup -S adminer && adduser -S adminer -G adminer
COPY ./conf/www.conf /www.conf.tmpl 
RUN rm -f /etc/php7/php-fpm.d/www.conf

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT [ "/run.sh" ]