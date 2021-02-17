#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd edgyr; ../build.sh ; popd
docker images
