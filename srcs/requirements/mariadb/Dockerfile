FROM alpine:3.7

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client gettext openrc

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY ./conf/my.cnf /my.cnf.tmpl
RUN chmod 744 /my.cnf.tmpl
RUN rm -f /etc/mysql/my.cnf
COPY ./conf/tmpl.sql /tmpl.sql

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 3306

ENTRYPOINT [ "/run.sh" ]