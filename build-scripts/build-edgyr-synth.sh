#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd edgyr-synth; ../build.sh ; popd
sudo docker images
