FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk update && apk upgrade
RUN apk add --no-cache vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
RUN mkdir -p /var/run/vsftpd/empty

COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 21

ENTRYPOINT [ "/run.sh" ]