#! /bin/bash

set -e

pushd "pocl-$POCL_VERSION/build"
echo "running CUDA tests"
../tools/scripts/run_cuda_tests > $LOGS/run_cuda_tests.log 2>&1
echo "CUDA tests finished"
popd
