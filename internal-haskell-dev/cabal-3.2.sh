#! /bin/bash

set -e

export CABAL_HOME=/root/.cabal/bin
export PATH=$CABAL_HOME:$PATH
$CABAL_HOME/cabal --version
$CABAL_HOME/cabal v2-update
/usr/bin/time $CABAL_HOME/cabal v2-install \
  --installdir=/usr/local/bin \
  --disable-optimization \
  --overwrite-policy=always \
cabal-install
