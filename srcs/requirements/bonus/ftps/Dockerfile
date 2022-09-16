FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="15-Sep-2022"

RUN apk add --no-cache vsftpd

# Copy certificates
# COPY 

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./tools/run.sh /run.sh
RUN chmod +x /run.sh

CMD [ './run.sh' ]