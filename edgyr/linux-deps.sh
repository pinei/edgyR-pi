#! /bin/bash

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  default-jdk-headless \
  file \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libnuma-dev \
  libpcre2-8-0 \
  libsodium-dev \
  lsof \
  mlocate \
  openssh-client \
  pkg-config \
  protobuf-compiler \
  python \
  python3 \
  python-dev \
  python3-dev \
  python3-venv \
  python-virtualenv \
  python3-virtualenv \
  software-properties-common \
  sudo \
  texinfo \
  time \
  tree \
  unzip \
  vim-nox \
  virtualenv \
  virtualenvwrapper \
  wget \
  zip
update-alternatives --set editor /usr/bin/vim.nox
apt-file update
updatedb
