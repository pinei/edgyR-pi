#! /bin/bash

set -e

export TAG=`basename $PWD`
echo "Creating a backup"
sudo docker tag $DOCKER_REPO/$TAG:latest $DOCKER_REPO/$TAG:backup
echo "Building $TAG"
sudo docker build --tag $DOCKER_REPO/$TAG .
