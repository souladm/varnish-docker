FROM alpine:3.10.1
LABEL maintainer="kosar@freedom.valor.ua"
LABEL vendor="1node"
LABEL lastUpdate="29-07-2019"
LABEL description="Varnish !!VERSION!! alpine"
EXPOSE 80

ENV VARNISH_MEMORY 1G
ENV VARNISH_BACKEND_PORT 80
ENV VARNISH_VER !!VERSION!!
ENV VARNISH_DL https://varnish-cache.org/_downloads/varnish-!!VERSION!!.tgz

RUN apk update && apk upgrade
# set timezone
RUN apk add tzdata && cp /usr/share/zoneinfo/Europe/Kiev /etc/localtime && apk del tzdata
# install varnish
RUN cd /tmp && wget https://varnish-cache.org/_downloads/varnish-!!VERSION!!.tgz && \
    tar xzvf ./varnish-!!VERSION!!.tgz && cd varnish-!!VERSION!!/ && \
    apk add --no-cache --virtual deps make automake autoconf libtool m4 pkgconf py-docutils \
    linux-headers python3 py-sphinx && \
    apk add gcc pcre-dev libexecinfo-dev musl-dev readline-dev ncurses-dev && \
    sed -i '1 i\AUTOMAKE_OPTIONS = subdir-objects' ./Makefile.am && \
    sed -i '1 i\AUTOMAKE_OPTIONS = subdir-objects' bin/varnishd/Makefile.am && \
    sed -i '1 i\AUTOMAKE_OPTIONS = subdir-objects' lib/libvarnishapi/Makefile.am && \
    ./autogen.sh && ./configure && \
    sed -i '1 i\#include <sys/stat.h>' include/vpf.h && \
    sed -i '1 i\#include <sys/types.h>' include/vsb.h && \
    make && make install && cd /tmp && rm -rf /tmp/varnish-!!VERSION!!* && \
    apk del deps

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
