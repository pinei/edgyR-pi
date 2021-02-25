#! /bin/bash

set -e

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=1
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cd $SOURCE_DIR
curl -Ls \
  https://downloads.haskell.org/~ghc/8.2.2/ghc-8.2.2-src.tar.xz \
  | tar xJf -
cd ghc-8.2.2
./boot
./configure
make --jobs=$JOBS
make install
