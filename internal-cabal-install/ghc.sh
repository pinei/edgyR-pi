#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=3
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cd $SOURCE_DIR
curl -Ls https://downloads.haskell.org/~ghc/$GHC_VERSION/ghc-$GHC_VERSION-src.tar.xz \
  | tar xJf -
cd ghc-$GHC_VERSION
./boot
./configure
make --jobs=$JOBS
make install

cd $SOURCE_DIR
zip -rmyq ghc-$GHC_VERSION.zip ghc-$GHC_VERSION
