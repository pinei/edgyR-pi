#! /bin/bash

set -e

echo "Installing library includes"
apt-get install -qqy --no-install-recommends \
  libbz2-dev \
  libcairo2-dev \
  libgit2-dev \
  libicu-dev \
  libjpeg8-dev \
  libjpeg-turbo8-dev \
  liblzma-dev \
  libncurses-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libreadline-dev \
  libtiff5-dev \
  lsb-release \
  pkg-config \
  tk-dev \
  zlib1g-dev
apt-get clean
