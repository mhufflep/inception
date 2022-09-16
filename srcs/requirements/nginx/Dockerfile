FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="14-Sep-2022"

RUN apk update && apk upgrade -y
RUN apk add --no-cache nginx openssl nano

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=RU/ST=Kazan/CN=mhufflep" \
	-keyout /etc/ssl/private/server.key \
	-out /etc/ssl/certs/server.crt

COPY ./conf/default.conf /etc/nginx/sites-available

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf && \
	rm -f /etc/nginx/sites-available/default

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 443

CMD [ '/run.sh' ]