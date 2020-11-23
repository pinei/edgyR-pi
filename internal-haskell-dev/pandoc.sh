#! /bin/bash

set -e

export PATH=$EDGYR_BIN:$PATH
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
  --flags="embed_data_files https" \
  --ghc-options="-fasm" \
  --overwrite-policy=always \
pandoc

if [ ! -e /usr/local/bin/pandoc ]
then
  sudo cp --verbose --dereference $EDGYR_BIN/pandoc /usr/local/bin/pandoc
fi
ldd /usr/local/bin/pandoc
