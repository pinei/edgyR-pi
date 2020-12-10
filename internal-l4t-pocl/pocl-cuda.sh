#! /bin/bash

set -e

echo ""
echo "downloading pocl source"
rm -fr pocl-*
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

echo "running CUDA tests"
../tools/scripts/run_cuda_tests > $LOGS/run_cuda_tests.log 2>&1
echo "CUDA tests finished"

ninja install
cp $SCRIPTS/pocl.conf /etc/ld.so.conf.d/
/sbin/ldconfig --verbose
cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1
popd
