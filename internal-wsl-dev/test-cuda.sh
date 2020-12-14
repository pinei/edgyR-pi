#! /bin/bash

set -e

pushd pocl*/build
echo "running CUDA tests"
cp $SCRIPTS/run_cuda_tests ../tools/scripts/run_cuda_tests
../tools/scripts/run_cuda_tests
echo "CUDA tests finished"
popd
