#! /bin/bash

echo "Installing build dependencies"
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
  mlocate \
  libbz2-dev \
  libcairo2-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libjpeg8-dev \
  libjpeg-turbo8-dev \
  liblzma-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libreadline-dev \
  libtiff5-dev \
  pkg-config \
  software-properties-common \
  sudo \
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  vim-nox \
  wget \
  zip \
  zlib1g-dev
