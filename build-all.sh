#! /bin/bash

set -e

grep -i -e "BogoMIPS" /proc/cpuinfo
grep -i -e "MemTotal" /proc/meminfo
for i in \
  internal-cabal-install \
  internal-pandoc \
  internal-r \
  internal-rstudio-server \
  internal-libnode-dev
do
  pushd $i
  ../build.sh
  popd
done

# run the rest only on Jetson
if [ `uname -m` != "x86_64" ]
then 
  pushd internal-jetson-pocl; ../build.sh; popd
  pushd edgyr; ../build.sh; popd
fi

docker images
