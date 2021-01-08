#! /bin/bash

set -e

export EDGYR_RELEASE=0.7.4.9999
for image in \
  internal-pandoc \
  internal-ubuntu-builder \
  edgyr
do
  sudo docker pull "edgyr/$image:$EDGYR_RELEASE"
done
