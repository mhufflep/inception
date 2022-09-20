FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client gettext

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./conf/tmpl.sql /tmpl.sql

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 3306

ENTRYPOINT [ "/run.sh" ]