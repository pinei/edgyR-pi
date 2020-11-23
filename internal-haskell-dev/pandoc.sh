#! /bin/bash

set -e

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
  --global \
  --overwrite-policy=always \
pandoc
