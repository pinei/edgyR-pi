#! /bin/bash

set -e

export EDGYR_RELEASE=0.7.4.9999
for image in \
  internal-ubuntu-builder \
  internal-l4t-builder \
  edgyr
do
  sudo docker tag "edgyr/$image:latest" "edgyr/$image:$EDGYR_RELEASE"
  sudo docker push "edgyr/$image:$EDGYR_RELEASE"
done
