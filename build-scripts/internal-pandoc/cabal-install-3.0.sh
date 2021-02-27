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
cabal user-config init --force
diff $SCRIPTS/cabal-config-1 /root/.cabal/config || true
cp $SCRIPTS/cabal-config-1 /root/.cabal/config
cabal update

echo "Upgrading cabal-install"
cabal install \
  --jobs=$JOBS \
cabal-install
ldd /usr/local/bin/cabal
