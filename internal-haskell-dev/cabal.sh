#! /bin/bash

set -e

export PATH=$EDGYR_BIN:$PATH
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
  --overwrite-policy=always \
cabal-install

if [ ! -e /usr/local/bin/cabal ]
then
  sudo cp --verbose --dereference $EDGYR_BIN/cabal /usr/local/bin/cabal
fi
ldd /usr/local/bin/cabal

cabal user-config update
