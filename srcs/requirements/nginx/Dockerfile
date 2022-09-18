FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="14-Sep-2022"

RUN apk update && apk upgrade
RUN apk add --no-cache nginx nano gettext

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 443

CMD [ '/run.sh' ]