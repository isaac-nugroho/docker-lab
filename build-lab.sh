#!/bin/bash
PARENT=$(pwd)
echo "Cleaning up ..."
docker images prune

echo "base-image"
cd $PARENT/base-image
docker build . -t inugroho/base-image
docker push inugroho/base-image

echo "base-image-jre"
cd $PARENT/base-image-jre
docker build . -t inugroho/base-image-jre
docker push inugroho/base-image-jre

echo "base-consul"
cd $PARENT/phensley-dns
docker build . -t inugroho/phensley-dns
docker push inugroho/phensley-dns

echo "base-consul-jre"
cd $PARENT/phensley-dns
docker build . -t inugroho/phensley-dns
docker push inugroho/phensley-dns

echo "consul-cassandra"
cd $PARENT/consul-cassandra
docker build . -t inugroho/consul-cassandra
docker push inugroho/consul-cassandra
cd $PARENT

echo "consul-nomad"
cd $PARENT/consul-nomad
docker build . -t inugroho/consul-nomad
docker push inugroho/consul-nomad
cd $PARENT

echo "activemq"
cd $PARENT/activemq
docker build . -t inugroho/activemq
docker push inugroho/activemq

echo "builder"
cd $PARENT/builder
docker build . -t inugroho/builder
docker push inugroho/builder

echo "microservice-base"
cd $PARENT/microservice-base
docker build . -t inugroho/microservice-base
docker push inugroho/microservice-base

echo "Cleaning up ..."
docker images prune
