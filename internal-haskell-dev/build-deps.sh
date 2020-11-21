#! /bin/bash

set -e

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  autoconf \
  automake \
  build-essential \
  ca-certificates \
  curl \
  file \
  git \
  git-lfs \
  haskell-platform \
  haskell-stack \
  libgmp-dev \
  libncurses-dev \
  libnuma-dev \
  llvm-3.9 \
  llvm-4.0 \
  llvm-5.0 \
  llvm-6.0 \
  llvm-7 \
  llvm-8 \
  llvm-9 \
  llvm-10 \
  mlocate \
  pkg-config \
  python3 \
  python3-sphinx \
  software-properties-common \
  sudo \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
