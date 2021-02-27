#! /bin/bash

set -e

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  autoconf \
  automake \
  build-essential \
  ca-certificates \
  clang-3.9 \
  clang-format-3.9 \
  clang-tidy-3.9 \
  curl \
  haskell-platform \
  libclang-3.9-dev \
  libgmp-dev \
  libnuma-dev \
  llvm-3.9 \
  llvm-3.9-dev \
  llvm-3.9-runtime \
  llvm-3.9-tools \
  time \
  wget \
  xz-utils \
  zlib1g-dev
apt-get autoremove -y
apt-get clean

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
