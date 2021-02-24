#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd internal-pandoc; ../build.sh ; popd
docker images
