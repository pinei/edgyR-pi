#! /bin/bash

set -e

cabal --version
cabal user-config update
cabal new-update
/usr/bin/time cabal new-install \
  --disable-executable-dynamic \
  --ghc-options="-fasm" \
  --global \
  --overwrite-policy=always \
cabal-install
if [ -f /root/.cabal/bin/cabal ]
then
  cp --verbose --dereference /root/.cabal/bin/cabal /usr/local/bin/
fi
cabal --version
cabal user-config update
