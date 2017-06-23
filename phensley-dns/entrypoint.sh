#!/bin/sh
export IP_ADDRESS="$(grep -m 1 "${HOSTNAME}" /etc/hosts | head -1 | awk '{IFS=" "; print $1 }')"
echo "nameserver ${IP_ADDRESS}" > /data/dns/resolv.conf
echo "search ${DOMAIN}" >> /data/dns/resolv.conf
/dockerdns --domain ${DOMAIN:denise}
