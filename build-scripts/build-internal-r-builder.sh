#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="pinei"
pushd internal-r-builder; ../build.sh ; popd
sudo docker images
