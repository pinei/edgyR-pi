#! /bin/bash

set -e

export TAG=`basename $PWD`
echo "Building $TAG"
sudo docker build --tag $DOCKER_REPO/$TAG .
