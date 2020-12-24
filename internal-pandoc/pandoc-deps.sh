#! /bin/bash

set -e

apt-get update
apt-get install -qqy --no-install-recommends \
  apt-file \
  curl \
  mlocate \
  vim-nox \
  wget

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=2
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cabal user-config update
cabal v2-update

cd $SOURCE_DIR
wget -q -O - https://hackage.haskell.org/package/pandoc-$PANDOC_VERSION/pandoc-$PANDOC_VERSION.tar.gz \
  | tar xzf -
cd pandoc-$PANDOC_VERSION
cabal v2-build \
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
  --ghc-options="-fllvm" \
  --jobs=$JOBS \
  --only-dependencies
