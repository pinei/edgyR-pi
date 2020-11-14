#! /bin/bash

set -e

sudo docker build --tag $DOCKER_REPO/$1 . > /tmp/$1-build.log 2>&1
sudo docker push $DOCKER_REPO/$1 > /tmp/$1-push.log 2>&1 &
