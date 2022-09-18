FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="16-Sep-2022"

ARG	ADMINER_VERSION=4.8.1
ARG ADMINER_FOLDER=/var/www/html/adminer

RUN apk update && apk upgrade
RUN	apk add --no-cache wget \
	php7-session php7 php7-fpm php7-mysqli
	
RUN mkdir -p "$ADMINER_FOLDER" /run/php

RUN wget "https://github.com/vrana/adminer/releases/download/v$ADMINER_VERSION/adminer-$ADMINER_VERSION.php" \
	--output-document="$ADMINER_FOLDER/adminer.php"

COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

CMD [ './run.sh' ]