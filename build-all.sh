#! /bin/bash -v

set -e

pushd internal-r4jetson
../build-and-push.sh internal-r4jetson
popd
pushd internal-rstudio4jetson
../build-and-push.sh internal-rstudio4jetson &
popd
pushd edgyr-lab
../build-and-push.sh edgyr-lab &
popd
wait
pushd edgyr-studio
../build-and-push.sh edgyr-studio
popd
ps -ef | grep docker
