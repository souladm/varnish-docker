FROM ubuntu:18.04
LABEL maintainer="kosar@freedom.valor.ua"
LABEL vendor="1node"
LABEL created="10-02-2019"
LABEL lastUpdate="21-03-2019"
LABEL description="varnish-4.1 container based on UBUNTU 18.04"
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y
# set timezone
RUN echo 'Europe/Kiev' > /etc/timezone
RUN apt install -y tzdata wget
# install varnish
RUN apt install binutils binutils-common binutils-x86-64-linux-gnu \
    cpp cpp-7 gcc gcc-7 gcc-7-base libasan4 libatomic1 libbinutils \
    libc-dev-bin libc6-dev libcc1-0 libcilkrts5 libedit2 libgcc-7-dev \
    libgomp1 libisl19 libitm1 libjemalloc1 liblsan0 libmpc3 libmpfr6 \
    libmpx2 libquadmath0 libtsan0 libubsan0 libvarnishapi1 linux-libc-dev \
    manpages manpages-dev
RUN cd /tmp && \
    wget https://packagecloud.io/varnishcache/varnish41/packages/ubuntu/xenial/varnish_4.1.10-1~xenial_amd64.deb/download.deb -O varnish4.deb && \
    dpkg -i /tmp/varnish4.deb && \
    rm /tmp/varnish4.deb
EXPOSE 80
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "bash", "docker-entrypoint.sh" ]
