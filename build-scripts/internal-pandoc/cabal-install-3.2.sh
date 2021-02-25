#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=1
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

which cabal
cabal --version
cabal update
cabal install \
  --disable-benchmarks \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --ghc-options="-fasm" \
  --jobs=$JOBS \
cabal-install

echo "Copying new 'cabal' to '/usr/local/bin'
cp --verbose --dereference $HOME/.cabal/bin/cabal /usr/local/bin/cabal
ldd /usr/local/bin/cabal
