#! /bin/bash

set -e

echo "downloading pocl source"
rm -fr pocl*
wget -q -O - https://github.com/pocl/pocl/archive/v$POCL_VERSION.tar.gz \
  | tar xzf -

pushd "pocl-$POCL_VERSION"
mkdir --parents build; cd build
cmake \
  -G Ninja \
  -DLLC_HOST_CPU=generic \
  -DENABLE_CUDA=ON \
  -DINSTALL_OPENCL_HEADERS=1 \
..

ninja
ninja install

cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1
popd
