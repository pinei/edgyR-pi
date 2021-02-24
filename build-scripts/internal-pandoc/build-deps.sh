#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  build-essential \
  ca-certificates \
  cabal-install \
  curl \
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
apt-get clean
