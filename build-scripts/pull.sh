#! /bin/bash

set -e

echo "pulling edgyR images"
for image in \
  internal-pandoc \
  internal-ubuntu-builder \
  edgyr
do
  sudo docker pull "edgyr/$image:latest"
done

echo "Pulling L4T images"
for image in \
  nvcr.io/nvidia/l4t-base:r32.5.0 \
  nvcr.io/nvidia/l4t-base:r32.4.4 \
  nvcr.io/nvidia/l4t-ml:r32.5.0-py3 \
  nvcr.io/nvidia/l4t-ml:r32.4.4-py3
do
  sudo docker pull "$image"
done
