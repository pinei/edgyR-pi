#! /bin/bash

set -e

export PATH=$EDGYR_BIN:$PATH
$EDGYR_BIN/cabal user-config update
$EDGYR_BIN/cabal new-update
/usr/bin/time $EDGYR_BIN/cabal new-install \
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
  sudo mkdir --parents $BINARIES/bin
  sudo cp --verbose --dereference $EDGYR_BIN/pandoc $BINARIES/bin/pandoc
fi
ldd /usr/local/bin/pandoc
