#!/bin/sh

if [ x$VARNISH_CONFIG_FILE = x ] && [ x$VARNISH_BACKEND_ADDRESS = x ]; then
  echo "You need to set either VARNISH_CONFIG_FILE or VARNISH_BACKEND_ADDRESS variable."
  exit 0
fi

mkdir -p /var/lib/varnish/$(hostname) && chown nobody /var/lib/varnish/$(hostname)

if [ x${VARNISH_CONFIG_FILE} = x ]; then
  varnishd -s malloc,${VARNISH_MEMORY} -a :80 -b ${VARNISH_BACKEND_ADDRESS}:${VARNISH_BACKEND_PORT} -F
else
  varnishd -s malloc,${VARNISH_MEMORY} -a :80 -f ${VARNISH_CONFIG_FILE} -F
fi
