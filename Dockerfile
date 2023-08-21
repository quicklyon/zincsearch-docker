FROM debian:11.7-slim

LABEL maintainer "zhouyueqiu zhouyueqiu@easycorp.ltd"

ENV OS_ARCH="amd64" \
    OS_NAME="debian-11" \
    HOME_PAGE="https://zincsearch.com/"

COPY debian/prebuildfs /

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

ARG IS_CHINA="true"
ENV MIRROR=${IS_CHINA}

RUN install_packages curl wget zip unzip s6

# Install zincsearch
ARG VERSION
ENV APP_VER=${VERSION}
ENV EASYSOFT_APP_NAME="ZincSearch $APP_VER"
ENV ZINC_DATA_PATH="/data"

WORKDIR /apps/zincsearch
RUN mkdir bin \
    && curl -skL https://github.com/zincsearch/zincsearch/releases/download/v${APP_VER}/zincsearch_${APP_VER}_Linux_x86_64.tar.gz | tar xvz -C . \
    && mv zincsearch ./bin

# Copy zincsearch config files
COPY debian/rootfs /

EXPOSE 4080

# Persistence directory
VOLUME [ "/data"]

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
