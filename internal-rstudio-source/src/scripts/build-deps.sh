#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  ant \
  apt-file \
  build-essential \
  clang \
  cmake \
  curl \
  debsigs \
  dpkg-sig \
  expect \
  fakeroot \
  file \
  git \
  git-lfs \
  gnupg1 \
  libacl1-dev \
  libattr1-dev \
  libbz2-dev \
  libcap-dev \
  libclang-6.0-dev \
  libclang-dev \
  libcurl4-openssl-dev \
  libegl1-mesa \
  libfuse2 \
  libgl1-mesa-dev \
  libgtk-3-0 \
  libpam0g-dev \
  libpam-dev \
  libpango1.0-dev \
  libssl-dev \
  libuser1-dev \
  libxslt1-dev \
  lsof \
  mlocate \
  openjdk-8-jdk \
  patchelf \
  pkg-config \
  python \
  rrdtool \
  software-properties-common \
  sudo \
  time \
  tree \
  unzip \
  uuid-dev \
  vim-nox \
  wget \
  zip \
  zlib1g-dev
sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
