#! /bin/bash

set -e

echo ""
echo "Downloading pocl source"
git clone https://github.com/pocl/pocl.git

pushd "pocl"
mkdir --parents build; cd build
cmake \
  -G Ninja \
  -DLLC_HOST_CPU=generic \
  -DENABLE_CUDA=ON \
  -DINSTALL_OPENCL_HEADERS=1 \
  -DENABLE_TESTSUITES="conformance" \
..

ninja prepare_examples
ninja

../tools/scripts/run_cuda_tests > $LOGS/run_cuda_tests.log 2>&1
clinfo > $LOGS/clinfo.log 2>&1
ctest --output-on-failure -L conformance_suite_micro > $LOGS/ctest.log 2>&1

ninja install
cp -rp /usr/local/etc/OpenCL /etc/
popd
