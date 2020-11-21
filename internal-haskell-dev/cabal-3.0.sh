#! /bin/bash

set -e

cabal --version
cabal update
/usr/bin/time cabal install \
  --disable-optimization \
cabal-install
