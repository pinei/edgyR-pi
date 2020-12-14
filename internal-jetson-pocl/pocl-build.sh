#! /bin/bash

set -e

pushd pocl
mkdir --parents build; cd build

# LLVM 10 doesn't recognize a Xavier so we use "generic"
if [ `grep -e "atomics fphp asimdhp" | wc -l` -gt "0" ]
then
  cmake \
    -G Ninja \
    -DLLC_HOST_CPU=generic \
    -DENABLE_CUDA=ON \
    -DINSTALL_OPENCL_HEADERS=1 \
  ..
else
  cmake \
    -G Ninja \
    -DENABLE_CUDA=ON \
    -DINSTALL_OPENCL_HEADERS=1 \
  ..
fi

ninja
ninja install

cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1
popd
