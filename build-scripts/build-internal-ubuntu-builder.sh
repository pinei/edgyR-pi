#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="pinei"
pushd internal-ubuntu-builder; ../build.sh ; popd
sudo docker images
