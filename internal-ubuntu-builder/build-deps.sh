#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  cabal-install \
  libgmp-dev \
  libnuma-dev \
  time \
  zlib1g-dev
apt-get clean
