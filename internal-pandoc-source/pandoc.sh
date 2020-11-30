#! /bin/bash

set -e

# The Nano only has 4 GB of RAM. As a result, the GHC builds swamp the available
# RAM and multi-job makes are problematic - they swap and the system appears
# unresponsive.
#
# So we only run two-job makes if we have less than 7 GB of RAM.
export RAM_KILOBYTES=`grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'`
if [ $RAM_KILOBYTES -ge "7000000" ]
then
  export JOBS=`nproc`
else
  export JOBS=2
fi
echo "Installing"
echo " -- starting GHC builds"
echo " -- RAM_KILOBYTES = $RAM_KILOBYTES; 'make' will use $JOBS jobs."

export PATH=$EDGYR_BIN:$PATH
$EDGYR_BIN/cabal user-config update
$EDGYR_BIN/cabal new-update
/usr/bin/time $EDGYR_BIN/cabal new-install \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --disable-shared \
  --flags="embed_data_files https" \
  --ghc-options="+RTS -A128m -n2m -RTS" \
  --jobs=$JOBS \
  --overwrite-policy=always \
pandoc

if [ ! -e /usr/local/bin/pandoc ]
then
  sudo cp --verbose --dereference $EDGYR_BIN/pandoc /usr/local/bin/pandoc
fi
ldd /usr/local/bin/pandoc
