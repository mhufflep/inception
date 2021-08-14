#FROM alpine:3.8
FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.28 

LABEL maintainer="mhufflep@student.21-school.ru"

RUN apk update && apk upgrade

RUN apk add vim 
RUN apk add openrc --no-cache
RUN apk add mariadb mariadb-client
#check
VOLUME ["/var/lib/mysql"]
VOLUME [ "/sys/fs/cgroup" ]

RUN mkdir -p /run/mysqld/

#check path
COPY ./mysql.cnf /etc/mysql/mysql.cnf
RUN chmod 744 /etc/mysql/mysql.cnf

# COPY ./tools/create.sql ./
COPY start.sh /
RUN chmod +x start.sh
# -- scripts --

EXPOSE 3306

ENTRYPOINT ./start.sh