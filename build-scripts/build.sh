#! /bin/bash

set -e

export TAG=`basename $PWD`
echo "Creating a backup"
sudo docker tag $DOCKER_REPO/$TAG:latest $DOCKER_REPO/$TAG:backup || true
echo "Building $TAG"
/usr/bin/time sudo docker build --tag $DOCKER_REPO/$TAG . > $HOME/build-logs/$TAG.log 2>&1
