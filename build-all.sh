#! /bin/bash

set -e

grep -i -e "BogoMIPS" /proc/cpuinfo
grep -i -e "MemTotal" /proc/meminfo
for i in \
  internal-cabal-3.0 \
  internal-pandoc-deps \
  internal-pandoc \
  internal-r \
  internal-rstudio-server
do
  pushd $i
  ../build.sh
  popd
done

# run the rest only on Jetson
if [ `uname -m` != "x86_64" ]
then 
  pushd internal-v8-builder; ../build.sh; popd
  pushd internal-jetson-pocl; ../build.sh; popd
  pushd edgyr; ../build.sh; popd
fi

docker images
