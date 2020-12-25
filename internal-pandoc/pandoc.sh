#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=3
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cd $SOURCE_DIR/pandoc-$PANDOC_VERSION
cabal install \
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
