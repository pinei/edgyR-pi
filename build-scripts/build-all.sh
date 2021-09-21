#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="pinei"

for repo in \
  internal-r-builder \
  edgyr-pi
do
  pushd $repo; ../build.sh ; popd
done

docker images
