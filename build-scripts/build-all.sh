#! /bin/bash

set -e

export REGISTRY="docker.io"
export ACCOUNT="edgyr"

# pandoc won't build on a Nano - not enough RAM
if [ `grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'` -gt "7000000" ]
then
  echo "Building 'internal-pandoc' image"
  pushd internal-pandoc; ../build.sh ; popd
else
  echo "Running on a Nano - pullng 'internal-pandoc' image from Docker Hub"
  sudo docker pull "edgyr/internal-pandoc:latest"
fi

for repo in \
  internal-ubuntu-builder \
  edgyr
do
  pushd $repo; ../build.sh ; popd
done

docker images
