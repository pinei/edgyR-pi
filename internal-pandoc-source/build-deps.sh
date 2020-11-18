#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  curl \
  file \
  git \
  git-lfs \
  haskell-platform \
  mlocate \
  sudo \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
