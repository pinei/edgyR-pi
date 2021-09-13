#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"
pushd hirsute-livecoding; ../build.sh ; popd
sudo docker images
