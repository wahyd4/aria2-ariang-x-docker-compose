#!/bin/sh
echo "Run aria2c and ariaNG"
/usr/bin/aria2c --conf-path="/root/aria2.conf" -D --enable-rpc --rpc-listen-all \
&& nginx -g 'daemon off;'
