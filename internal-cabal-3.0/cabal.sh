#! /bin/bash

set -e

# for some reason llvm-3.7 only exists in the arm64 Bionic repos
if [ `uname -m` = "x86_64" ]
then
  export LLVM=""
else
  export LLVM="-fllvm"
fi

which cabal
cabal --version
cabal user-config update
cabal update
/usr/bin/time cabal install \
  --disable-benchmarks \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --ghc-options "$LLVM" \
cabal-install

sudo cp --verbose --dereference $EDGYR_BIN/cabal /usr/local/bin/cabal
ldd /usr/local/bin/cabal
