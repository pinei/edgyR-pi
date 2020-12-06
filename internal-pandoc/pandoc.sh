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
  export JOBS=3
fi
echo "Installing"
echo " -- RAM_KILOBYTES = $RAM_KILOBYTES; 'make' will use $JOBS jobs."

cabal user-config update
cabal new-update
# see https://github.com/jgm/pandoc/blob/2.11.2/linux/make_artifacts.sh
/usr/bin/time cabal new-install \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --enable-executable-static \
  --flags="embed_data_files https" \
  --ghc-options "-optc-Os -optl=-pthread" \
  --jobs=$JOBS \
  --overwrite-policy=always \
pandoc

sudo cp --verbose --dereference $EDGYR_BIN/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc
rm -fr $HOME/.cabal
