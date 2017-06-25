#!/bin/sh

if [[ ! -d /data/repository ]]; then
  mkdir -p /data/repository
  chown -R nobody:nobody /data/repository
fi
if [[ ! -d /data/gradle-workdir ]]; then
  mkdir -p /data/gradle-workdir
  chown -R nobody:nobody /data/gradle-workdir
fi

mkdir -p /home/nobody/.gradle
cd /home/nobody/.gradle
ln -s /data/gradle-workdir/caches caches
ln -s /data/gradle-workdir/native native
ln -s /data/gradle-workdir/wrapper wrapper
chown nobody:nobody -R /home/nobody/.gradle

cd /home/nobody/.m2
ln -s /data/repository repository
chown nobody:nobody repository

if [[ -d /data/.ssh ]]; then
  cp /data/.ssh/* /home/nobody/.ssh/
fi
