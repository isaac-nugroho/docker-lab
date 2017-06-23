#!/bin/bash
PARENT=$(pwd)
echo "Cleaning up ..."
docker rmi inugroho/base-image
docker rmi inugroho/phensley-dns
docker rmi inugroho/builder
docker rmi inugroho/microservice-base

echo "base-image"
cd $PARENT/base-image
docker build . -t inugroho/base-image
docker push inugroho/base-image

echo "phensley-dns"
cd $PARENT/phensley-dns
docker build . -t inugroho/phensley-dns
docker push inugroho/phensley-dns

echo "builder"
cd $PARENT/builder
docker build . -t inugroho/builder
docker push inugroho/builder

echo "microservice-base"
cd $PARENT/microservice-base
docker build . -t inugroho/microservice-base
docker push inugroho/microservice-base

cd $PARENT
