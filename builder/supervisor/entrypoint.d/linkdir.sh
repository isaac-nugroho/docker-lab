#!/bin/sh

if [[ ! -d /data/repository ]]; then
  mkdir -p /data/repository
  chown -R nobody:nobody /data/repository
fi
if [[ ! -d /data/gradle-workdir ]]; then
  mkdir -p /data/gradle-workdir
  chown -R nobody:nobody /data/gradle-workdir
fi

cd /home/nobody
ln -s /data/gradle-workdir .gradle
chown nobody:nobody .gradle

cd /home/nobody/.m2
ln -s /data/repository repository
chown nobody:nobody repository
