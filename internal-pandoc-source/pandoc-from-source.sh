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
apt-get clean

echo "Updating 'cabal' package list"
cabal update

echo "Building 'pandoc' with 'cabal'"
/usr/bin/time cabal install pandoc -fembed_data_files
