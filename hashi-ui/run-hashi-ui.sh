#!/bin/dumb-init /bin/sh
set -e
sleep 30
hashi-ui --nomad-enable --consul-enable --nomad-address $NOMAD_ADDRESS
