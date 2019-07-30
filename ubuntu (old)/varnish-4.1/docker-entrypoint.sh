#!/bin/bash
exec bash -c "varnishd -a :80 -T 127.0.0.1:6081 -s malloc,1G -F -f /etc/varnish/default.vcl"
