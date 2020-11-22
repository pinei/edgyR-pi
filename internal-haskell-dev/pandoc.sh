#! /bin/bash

set -e

cabal --version
cabal user-config update
cabal update
/usr/bin/time cabal install \
  --disable-coverage \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --flags="embed_data_files https" \
  --ghc-options="-fasm" \
  --global \
  --overwrite-policy=always \
pandoc
