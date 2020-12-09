#! /bin/bash

set -e

echo ""
echo "Downloading pocl source"
export WHERE="https://github.com/pocl/pocl/archive"
export POCL_TARBALL="v$POCL_VERSION.tar.gz"
curl -Ls "$WHERE/$POCL_TARBALL" \
  | tar -xzf -
pushd "pocl-$POCL_VERSION"
mkdir --parents build
cd build
cmake -DLLC_HOST_CPU=aarch64 ..
popd
