FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk add --no-cache redis 

COPY ./conf/redis.cong /etc/redis/redis.conf

EXPOSE 6379

CMD [ '/run.sh' ]