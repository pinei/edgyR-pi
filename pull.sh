#! /bin/bash

set -e

for image in \
  internal-pandoc \
  internal-ubuntu-builder \
  edgyr
do
  sudo docker pull "edgyr/$image:latest"
done
