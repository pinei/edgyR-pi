#! /bin/bash

set -e

cabal user-config update
cabal v2-update
cabal v2-install \
  --disable-benchmarks \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --flags="embed_data_files https" \
pandoc

cp --verbose --dereference $HOME/.cabal/bin/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc
