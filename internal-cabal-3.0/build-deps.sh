#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  autoconf \
  automake \
  build-essential \
  curl \
  file \
  ghc \
  git \
  git-lfs \
  libgmp-dev \
  libnuma-dev \
  llvm-3.9-dev \
  llvm-3.9-runtime \
  llvm-3.9-tools \
  mlocate \
  python3-sphinx \
  sudo \
  texlive-xetex \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
