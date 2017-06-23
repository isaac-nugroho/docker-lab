#!/bin/sh

if [[ ! -d /data/repository ]]; then
  mkdir -p /data/repository
  chown -R nobody:nobody /data/repository
fi
cd /home/nobody/.m2
ln -s /data/repository repository
chown nobody:nobody repository
