FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="17-Sep-2022"

ARG	CADVISOR_VERSION=0.45.0

RUN apk update && apk upgrade
RUN apk add --no-cache wget

RUN wget "https://github.com/google/cadvisor/releases/download/v$CADVISOR_VERSION/cadvisor-v$CADVISOR_VERSION-linux-arm64" \
	--output-document="/usr/bin/cadvisor"

RUN	chmod +x /usr/bin/cadvisor

COPY ./tools/run.sh /run.sh
RUN  chmod +x /run.sh

ENTRYPOINT [ "/run.sh" ]