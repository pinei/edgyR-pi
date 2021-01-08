#! /bin/bash

set -e

for image in \
  internal-pandoc \
  internal-ubuntu-builder \
  edgyr
do
  pushd $image; ../build.sh ; popd
done

docker images
