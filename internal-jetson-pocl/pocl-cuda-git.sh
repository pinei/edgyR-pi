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
  -DLLC_HOST_CPU=generic \
  -DENABLE_CUDA=ON \
  -DINSTALL_OPENCL_HEADERS=1 \
..

ninja
ninja install

cp $SCRIPTS/pocl.conf /etc/ld.so.conf.d/
/sbin/ldconfig --verbose
cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1
popd
