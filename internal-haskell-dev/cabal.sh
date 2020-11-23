#! /bin/bash

set -e

which cabal
cabal --version
cabal user-config update
cabal update
/usr/bin/time cabal install \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
cabal-install

export PATH=/root/.cabal/bin:$PATH
which cabal
cabal --version
cabal user-config update
cabal new-update
/usr/bin/time cabal new-install \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --ghc-options="-fasm" \
  --global \
  --overwrite-policy=always \
cabal-install

if [ ! -e /usr/local/bin/cabal ]
then
  cp --verbose --dereference /root/.cabal/bin/cabal /usr/local/bin/cabal
fi

cabal user-config update
