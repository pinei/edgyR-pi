#! /bin/bash

set -e

# for some reason llvm-3.7 only exists in the arm64 Bionic repos
if [ `uname -m` = "x86_64" ]
then
  export LLVM=""
else
  export LLVM="-fllvm"
fi

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
  --ghc-options "$LLVM -optc-Os -optl=-pthread" \
pandoc

sudo cp --verbose --dereference $EDGYR_BIN/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc
