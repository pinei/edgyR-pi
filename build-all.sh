#! /bin/bash

set -e

for i in \
  internal-build-dependencies \
  internal-ghc-8.2 \
  internal-cabal-3.0 \
  internal-cabal-3.2 \
  internal-ghc-8.6 \
  internal-pandoc \
  internal-r \
  internal-rstudio-server \
  edgyr 
do
  pushd $i
  ../build.sh
  popd
done
