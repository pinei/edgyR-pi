#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="pinei"
pushd edgyr-pi; ../build.sh ; popd
sudo docker images
