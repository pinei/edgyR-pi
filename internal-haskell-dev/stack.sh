#! /bin/bash

set -e

cabal --version
ghc --version
echo ""
cabal v2-update

echo "Building 'stack' with 'cabal'"
/usr/bin/time cabal v2-install \
  --jobs=`nproc` \
  --installdir=/usr/local/bin \
  --disable-optimization \
  --overwrite-policy=always \
stack
