FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk update && apk upgrade
RUN apk add --no-cache redis 

COPY ./conf/redis.conf /etc/redis.conf

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 6379

ENTRYPOINT [ "/run.sh" ]