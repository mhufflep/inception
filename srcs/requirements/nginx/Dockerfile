FROM debian:buster

LABEL maintainer="mhufflep@student.21-school.ru"

# -- Installing -- #
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl vim

COPY ./conf/nginx.conf /etc/nginx/sites-available

RUN ln -s /etc/nginx/sites-available/nginx.conf \
          /etc/nginx/sites-enabled/nginx.conf && \
	rm -f /etc/nginx/sites-available/default

# -- SSL -- #
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=ru/ST=Kazan/L=Kazan/O=no/OU=no/CN=mhuf" \
	-keyout /etc/ssl/private/mhufflep.key \
	-out /etc/ssl/certs/mhufflep.crt

EXPOSE 443

COPY ./tools/site /var/www/html/site

RUN mkdir -p /configurations
COPY ./tools/start.sh /configurations/start.sh
RUN chmod +x /configurations/start.sh

CMD ["/configurations/start.sh"]