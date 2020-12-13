#! /bin/bash

set -e

pushd "pocl-$POCL_VERSION/build"
echo "running CUDA tests"
../tools/scripts/run_cuda_tests
echo "CUDA tests finished"
popd
