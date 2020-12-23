#! /bin/bash

set -e

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  haskell-platform \
  time

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=3
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

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
  --ghc-options="-fllvm" \
  --jobs=$JOBS \
cabal-install

cp --verbose --dereference $HOME/.cabal/bin/cabal /usr/local/bin/cabal
ldd /usr/local/bin/cabal
