#!/bin/bash
PARENT=$(pwd)
echo "Cleaning up ..."

echo "base-image"
cd $PARENT/base-image
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi
echo "base-consul"
cd $PARENT/base-consul
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

#echo "base-image-jre"
#cd $PARENT/base-image-jre
#docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
#if [[ ! -z DO_PUSH ]]; then
#  docker push inugroho/$(basename $(pwd))
#fi

echo "base-oraclejdk8"
cd $PARENT/base-oraclejdk8
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "base-oraclejre8"
cd $PARENT/base-oraclejre8
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

#echo "consul-jre"
#cd $PARENT/consul-jre
#docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
#if [[ ! -z DO_PUSH ]]; then
#  docker push inugroho/$(basename $(pwd))
#fi

echo "consul-nomad"
cd $PARENT/consul-nomad
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "consul-oraclejdk8"
cd $PARENT/consul-oraclejdk8
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "consul-oraclejre8"
cd $PARENT/consul-oraclejre8
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "consul-nomad-oraclejre8"
cd $PARENT/consul-nomad-oraclejre8
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "consul-cassandra"
cd $PARENT/consul-cassandra
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "consul-activemq"
cd $PARENT/consul-activemq
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "microservice-base"
cd $PARENT/microservice-base
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

#echo "builder"
#cd $PARENT/builder
#docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
#if [[ ! -z DO_PUSH ]]; then
#  docker push inugroho/$(basename $(pwd))
#fi

echo "builder-oraclejdk8"
cd $PARENT/builder-oraclejdk8
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "jenkins"
cd $PARENT/jenkins
docker build . -t inugroho/$(basename $(pwd)) && docker rmi $(docker images --filter "dangling=true" -q)
if [[ ! -z DO_PUSH ]]; then
  docker push inugroho/$(basename $(pwd))
fi

echo "Cleaning up ..."
docker container prune --force
docker images prune
