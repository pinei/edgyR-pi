#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd synth; ../build.sh ; popd
sudo docker images
