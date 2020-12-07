#! /bin/bash

set -e

grep -i -e "BogoMIPS" /proc/cpuinfo
grep -i -e "MemTotal" /proc/meminfo
for i in \
  internal-build-dependencies \
  internal-cabal-3.0 \
  internal-pandoc \
  internal-r \
  internal-rstudio-server \
  edgyr 
do
  pushd $i
  ../build.sh
  popd
done
