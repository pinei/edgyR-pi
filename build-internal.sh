#! /bin/bash

set -e

for i in \
  internal-build-dependencies \
  internal-cabal-3.0 \
  internal-ghc-8.4 \
  internal-cabal-3.2 \
  internal-ghc-8.8 \
  internal-pandoc \
  internal-r \
  internal-rstudio-server
do
  pushd $i
  ../build.sh
  popd
done
