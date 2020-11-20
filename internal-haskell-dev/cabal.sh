#! /bin/bash

export PATH=/root/.cabal/bin:$PATH
cabal update
/usr/bin/time cabal install \
  --jobs=12 \
  --disable-optimization \
  --overwrite-policy=always \
cabal-install
cabal user-config update

cabal update
/usr/bin/time cabal install \
  --jobs=12 \
  --disable-optimization \
  --overwrite-policy=always \
cabal-install
cabal user-config update
cabal --version
