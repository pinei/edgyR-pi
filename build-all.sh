#! /bin/bash -v

set -e

pushd internal-pandoc-source
../build.sh &
popd
pushd internal-r-source
../build.sh &
popd
wait
pushd internal-rstudio-source
../build.sh
popd
pushd edgyr-ml
../build.sh
popd
sudo docker images
