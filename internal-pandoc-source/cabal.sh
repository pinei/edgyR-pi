#! /bin/bash

export PATH=/root/.cabal/bin:$PATH
cabal --version
ghc --version
cabal update

echo "Building 'cabal-install'' with 'cabal'"
/usr/bin/time cabal install \
  --jobs=12 \
  --disable-optimization \
  --ghc-options="-fllvm" \
cabal-install
cabal user-config update
cabal --version
