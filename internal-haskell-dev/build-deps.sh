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
  llvm-3.9-dev \
  llvm-4.0-dev \
  llvm-5.0-dev \
  llvm-6.0-dev \
  llvm-7-dev \
  llvm-8-dev \
  llvm-9-dev \
  llvm-10-dev \
  mlocate \
  pkg-config \
  python3 \
  python3-sphinx \
  software-properties-common \
  sudo \
  texlive-xetex \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
