#! /bin/bash

set -e

echo "Installing LLVM 6.0"
apt-get update
apt-get install -qqy --no-install-recommends \
  clang-6.0 \
  clang-format-6.0 \
  clang-tidy-6.0 \
  clang-tools-6.0 \
  libclang-6.0-dev \
  llvm-6.0 \
  llvm-6.0-dev \
  llvm-6.0-runtime \
  llvm-6.0-tools \
  python3

if [ `ram_kilobytes.sh` -lt 7000000 ]
then
  export JOBS=1
else
  export JOBS=`nproc`
fi
echo "JOBS = $JOBS"

cd $SOURCE_DIR
curl -Ls \
  https://downloads.haskell.org/~ghc/8.6.5/ghc-8.6.5-src.tar.xz \
  | tar xJf -
cd ghc-8.6.5
./boot
./configure
make --jobs=$JOBS
make install
