FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

ENV FTPS_USER_NAME ${ FTPS_USER_NAME:? FTPS_USER_NAME is required }

RUN addgroup -S $FTPS_USER_NAME && adduser -D -S $FTPS_USER_NAME -G $FTPS_USER_NAME

USER $FTPS_USER_NAME

RUN apk update && apk upgrade -y
RUN apk add --no-cache vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 21

CMD [ './run.sh' ]