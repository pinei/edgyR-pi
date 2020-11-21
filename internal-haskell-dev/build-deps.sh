#! /bin/bash

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
