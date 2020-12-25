#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=3
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cabal user-config update
cabal v2-update

cd $SOURCE_DIR
curl -Ls https://hackage.haskell.org/package/pandoc-$PANDOC_VERSION/pandoc-$PANDOC_VERSION.tar.gz \
  | tar xzf -
cd pandoc-$PANDOC_VERSION
cabal v2-install \
  --disable-benchmarks \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --flags="embed_data_files https" \
  --jobs=$JOBS \
  --overwrite-policy=always

cp --verbose --dereference $HOME/.cabal/bin/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc

cd ..
rm -fr pandoc-$PANDOC_VERSION
