FROM alpine:3.14

LABEL maintainer="Ilnur Timergaliev <timergaliev.code@gmail.com>" \
	  architecture="arm64v8/aarch64" \
	  build="17-Sep-2022"

ENV PROMETHEUS_VERSION=2.8.1

RUN apk update && apk upgrade
RUN apk add --no-cache wget

RUN wget "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-arm64.tar.gz" \
    && tar -xvzf prometheus-${PROMETHEUS_VERSION}.linux-arm64.tar.gz \
    && rm -f prometheus-${PROMETHEUS_VERSION}.linux-arm64.tar.gz     \
    && mv prometheus-${PROMETHEUS_VERSION}.linux-arm64 prometheus    \
    && cp prometheus/promtool    /usr/local/bin/                     \
    && cp prometheus/prometheus  /usr/local/bin/                     \
    && mkdir -p /etc/prometheus  /var/lib/prometheus                 \
    && cp -R prometheus/consoles/          /etc/prometheus/          \
    && cp -R prometheus/console_libraries/ /etc/prometheus/ 

# Not sure if they needed
# VOLUME /etc/prometheus
# VOLUME /var/lib/prometheus

COPY ./conf/prometheus.yml /etc/prometheus/prometheus.yml
COPY ./tools/run.sh ./run.sh
RUN  chmod +x ./run.sh

EXPOSE 9090

ENTRYPOINT [ "/run.sh" ]