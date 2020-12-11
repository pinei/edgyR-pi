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

# run the last two only on Jetson
if [ `uname -m` != "x86_64" ]
then 
  pushd edgyr; ../build.sh; popd
  pushd internal-l4t-pocl; ../build.sh; popd
fi
