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
  cabal-install \
  curl \
  file \
  git \
  git-lfs \
  gnupg \
  haskell-platform \
  libgmp-dev \
  libncurses-dev \
  libnuma-dev \
  mlocate \
  netbase \
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
  zlib1g-dev \
  zip
