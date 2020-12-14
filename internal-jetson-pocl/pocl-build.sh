#! /bin/bash

set -e

pushd pocl
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
