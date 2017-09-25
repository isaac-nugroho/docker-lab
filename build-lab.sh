#!/bin/bash
PARENT=$(pwd)
echo "Cleaning up ..."

echo "base-image"
cd $PARENT/base-image
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "base-consul"
cd $PARENT/base-consul
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "base-image-jre"
cd $PARENT/base-image-jre
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "consul-jre"
cd $PARENT/consul-jre
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "consul-nomad"
cd $PARENT/consul-nomad
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "base-consul-oraclejdk8"
cd $PARENT/consul-oraclejdk8
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "consul-cassandra"
cd $PARENT/consul-cassandra
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "consul-activemq"
cd $PARENT/consul-activemq
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "microservice-base"
cd $PARENT/microservice-base
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "builder"
cd $PARENT/builder
docker build . -t inugroho/$(basename $(pwd)) && docker push inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)

echo "Cleaning up ..."
docker container prune --force
docker images prune
