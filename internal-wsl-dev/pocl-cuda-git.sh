#! /bin/bash

set -e

echo "downloading pocl source"
rm -fr pocl*
git clone $GIT_REPO
pushd pocl
git checkout $BRANCH

mkdir --parents build; cd build
cmake \
  -G Ninja \
  -DENABLE_CUDA=ON \
  -DENABLE_SPIR=OFF \
  -DINSTALL_OPENCL_HEADERS=1 \
..

ninja
ninja install

cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1 || true
popd
