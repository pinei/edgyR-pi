#! /bin/bash

set -e

pushd pocl*/build
echo "running CUDA tests"
../tools/scripts/run_cuda_tests
echo "CUDA tests finished"
popd
