#! /bin/bash

set -e

cabal --version
cabal user-config update
cabal update
/usr/bin/time cabal install \
  --disable-coverage \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --ghc-options="-fasm" \
  --global \
  --jobs=`nproc` \
cabal-install
