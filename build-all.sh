#! /bin/bash

set -e

grep -i -e "BogoMIPS" /proc/cpuinfo
grep -i -e "MemTotal" /proc/meminfo
pushd internal-ubuntu-builder; ../build.sh &; popd
pushd internal-jetson-pocl; ../build.sh &; popd
wait
pushd edgyr; ../build.sh; popd

docker images
