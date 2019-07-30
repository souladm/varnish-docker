FROM alpine:3.10.1
LABEL maintainer="kosar@freedom.valor.ua"
LABEL vendor="1node"
LABEL lastUpdate="29-07-2019"
LABEL description="Varnish 6.2 alpine"
EXPOSE 80

ENV VARNISH_MEMORY 1G
ENV VARNISH_BACKEND_PORT 80

RUN apk update && apk upgrade
# set timezone
RUN apk add tzdata && cp /usr/share/zoneinfo/Europe/Kiev /etc/localtime && apk del tzdata
# install varnish
RUN apk add varnish=6.2.0-r1

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
