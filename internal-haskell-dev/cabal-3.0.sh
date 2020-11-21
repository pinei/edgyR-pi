#! /bin/bash

cabal --version
cabal update
/usr/bin/time cabal install \
  --disable-optimization \
cabal-install
