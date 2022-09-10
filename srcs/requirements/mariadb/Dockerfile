FROM debian:buster

LABEL maintainer="mhufflep@student.21-school.ru"

RUN apt-get update && apt-get upgrade -y

RUN apt-get -y install mariadb-server

RUN mkdir -p /run/mysqld && \
	chown mysql:mysql /run/mysqld

COPY ./conf/my.cnf /configurations/my.cnf

COPY ./tools/start.sh /configurations/start.sh
RUN chmod +x /configurations/start.sh

EXPOSE 3306

CMD ["/configurations/start.sh"]