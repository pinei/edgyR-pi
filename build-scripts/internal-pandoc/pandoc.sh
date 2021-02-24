#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=1
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

$HOME/.cabal/bin/cabal --version
$HOME/.cabal/bin/cabal user-config update
$HOME/.cabal/bin/cabal v2-update

$HOME/.cabal/bin/cabal v2-install \
  --disable-benchmarks \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --flags="embed_data_files https" \
  --ghc-options="-fasm" \
  --jobs=$JOBS \
  --overwrite-policy=always \
pandoc-$PANDOC_VERSION

cp --verbose --dereference $HOME/.cabal/bin/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc
