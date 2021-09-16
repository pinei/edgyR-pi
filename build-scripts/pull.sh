#! /bin/bash

set -e

echo "pulling edgyR images"
for image in \
  internal-ubuntu-builder \
  edgyr-pi
do
  sudo docker pull "edgyr-pi/$image:latest"
done
