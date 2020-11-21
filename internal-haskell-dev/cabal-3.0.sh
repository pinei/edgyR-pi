#! /bin/bash

set -e

cabal --version
cabal update
/usr/bin/time cabal install \
  --jobs=`nproc` \
  --disable-optimization \
cabal-install
