#!/bin/sh

# crond
/usr/sbin/crond -b -l 8

/usr/bin/mosdns start --dir /etc/mosdns