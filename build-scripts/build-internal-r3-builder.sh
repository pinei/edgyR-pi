#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd internal-r3-builder; ../build.sh ; popd
sudo docker images