#! /bin/bash

set -e

echo "pulling edgyR images"
for image in \
  internal-r-builder \
  edgyr-pi
do
  sudo docker pull "pinei/$image:latest"
done
