FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="14-Sep-2022"

RUN apk update && apk upgrade
RUN apk add --no-cache nginx openssl gettext

RUN mkdir -p /etc/nginx/http.d/ && \
	rm /etc/nginx/http.d/*.conf

COPY ./conf/default.conf /default.conf.tmpl

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh


ENTRYPOINT [ "/run.sh" ]