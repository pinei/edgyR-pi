#! /bin/bash

# we install cabal-install twice
# the first gets us to 3.0 and the
# second to 3.2
export CABAL_HOME=/root/.cabal
export PATH=$CABAL_HOME/bin:$PATH
cabal update
/usr/bin/time cabal install \
  --disable-optimization \
cabal-install

$CABAL_HOME/bin/cabal v2-update
/usr/bin/time $CABAL_HOME/bin/cabal v2-install \
  --installdir=/usr/local/bin \
  --disable-optimization \
  --overwrite-policy=always \
cabal-install

which cabal
cabal --version
