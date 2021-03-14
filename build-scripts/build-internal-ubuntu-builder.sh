#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd internal-ubuntu-builder; ../build.sh ; popd
docker images
