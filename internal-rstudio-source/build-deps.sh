#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  ant \
  apt-file \
  build-essential \
  ca-certificates \
  clang \
  cmake \
  curl \
  debsigs \
  default-jdk-headless \
  dpkg-sig \
  expect \
  fakeroot \
  file \
  gfortran \
  git \
  git-lfs \
  gnupg \
  gnupg1 \
  libacl1-dev \
  libattr1-dev \
  libbz2-dev \
  libcairo2-dev \
  libcap-dev \
  libclang-6.0-dev \
  libclang-dev \
  libcurl4-openssl-dev \
  libegl1-mesa \
  libfuse2 \
  libgl1-mesa-dev \
  libgtk-3-0 \
  libicu-dev \
  libjpeg8-dev \
  libjpeg-turbo8-dev \
  liblzma-dev \
  libnuma-dev \
  libpam-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libreadline-dev \
  libssl-dev \
  libtiff5-dev \
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
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  uuid-dev \
  vim-nox \
  wget \
  zip \
  zlib1g-dev

if [ `uname -m` = "x86_64" ]
then
  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
else
  update-alternatives --set java /usr/lib/jvm/java-8-openjdk-arm64/jre/bin/java
fi
