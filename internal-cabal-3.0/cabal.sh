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
echo " -- RAM_KILOBYTES = $RAM_KILOBYTES; 'make' will use $JOBS jobs."

which cabal
cabal --version
cabal user-config update
cabal update
/usr/bin/time cabal install \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-profiling \
  --disable-shared \
  --jobs=$JOBS \
cabal-install
$EDGYR_BIN/cabal user-config update

if [ ! -e /usr/local/bin/cabal ]
then
  sudo cp --verbose --dereference $EDGYR_BIN/cabal /usr/local/bin/cabal
fi
ldd /usr/local/bin/cabal
