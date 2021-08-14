#FROM alpine:3.8
FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.28 

LABEL maintainer="mhufflep@student.21-school.ru"

RUN apk update && apk upgrade

# -- Installing -- #
RUN apk add --no-cache openssl curl ca-certificates nginx 

RUN mkdir -p /run/nginx

RUN apk add vim

# -- SSL -- #
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-subj "/C=ru/ST=Kazan/L=Kazan/O=no/OU=no/CN=mhuf" \
		-keyout /etc/ssl/private/mhufflep.key -out /etc/ssl/certs/mhufflep.crt


# -- Config -- #
RUN rm -rf /etc/nginx/conf.d/default.conf

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./tools/images /var/www/html/images

#RUN mkdir -p /var/log/supervisor
#COPY ./tools/supervisord.conf /etc/supervisord.conf

# -- Main page -- #
RUN mkdir -p /var/www/
COPY ./tools/index.html /var/www/html/
COPY ./tools/style.css /var/www/html/

EXPOSE 443

#STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]