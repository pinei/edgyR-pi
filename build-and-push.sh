#! /bin/bash

set -e

export TAG=`basename $PWD`
echo "Building $TAG"
sudo docker build --tag $DOCKER_REPO/$TAG . > /tmp/$TAG.log 2>&1
sudo docker push $DOCKER_REPO/$TAG >> /tmp/$TAG.log 2>&1 &
