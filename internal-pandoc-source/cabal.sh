#! /bin/bash

echo "Updating 'cabal' package list"
cabal update

echo "Building 'cabal-install'' with 'cabal'"
/usr/bin/time cabal install \
  --disable-optimization \
cabal-install
