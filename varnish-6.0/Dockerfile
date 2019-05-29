FROM ubuntu:18.04
LABEL maintainer="kosar@freedom.valor.ua"
LABEL vendor="1node"
LABEL created="10-02-2019"
LABEL lastUpdate="21-03-2019"
LABEL description="varnish-6.0 container based on UBUNTU 18.04"
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt upgrade -y
# set timezone
RUN echo 'Europe/Kiev' > /etc/timezone
RUN apt install -y tzdata
# install varnish
RUN apt install -y debian-archive-keyring
RUN apt install -y curl gnupg apt-transport-https
RUN curl -L https://packagecloud.io/varnishcache/varnish60lts/gpgkey | apt-key add -
RUN echo 'deb https://packagecloud.io/varnishcache/varnish60lts/ubuntu/ bionic main\n \
deb-src https://packagecloud.io/varnishcache/varnish60lts/ubuntu/ bionic main' \
    > /etc/apt/sources.list.d/varnish.list
RUN apt update
RUN apt install -y varnish
EXPOSE 80
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "bash", "docker-entrypoint.sh" ]
