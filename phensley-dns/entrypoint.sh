#!/bin/sh
export IP_ADDRESS="$(grep -m 1 "${HOSTNAME}" /etc/hosts | head -1 | awk '{IFS=" "; print $1 }')"
mkdir -p /data/dns
echo "nameserver ${IP_ADDRESS}" > /data/dns/resolv.conf
echo "search ${DOMAIN}" >> /data/dns/resolv.conf
/dockerdns --domain ${DOMAIN:denise} --resolver $(grep -Eo "^nameserver\s+[0-9.]+" /etc/resolv.conf | awk '{ print $2; }')
