#! /bin/bash

set -e

echo "Installing command line tools"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  autoconf \
  automake \
  autotools-dev \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  emacs-nox \
  file \
  git \
  git-lfs \
  gnupg \
  libltdl-dev \
  libtool \
  libtool-bin \
  nano \
  pkg-config \
  software-properties-common \
  sudo \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip
apt-get clean -y
update-alternatives --set editor /usr/bin/vim.nox
