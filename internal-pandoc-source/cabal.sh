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
  --disable-profiling \
cabal-install
$EDGYR_BIN/cabal user-config update

if [ ! -e /usr/local/bin/cabal ]
then
  sudo cp --verbose --dereference $EDGYR_BIN/cabal /usr/local/bin/cabal
fi
ldd /usr/local/bin/cabal
