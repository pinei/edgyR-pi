#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-utils \
  apt-file \
  build-essential \
  ca-certificates \
  clang-10 \
  clinfo \
  cmake \
  curl \
  dialog \
  file \
  git \
  git-lfs \
  gnupg \
  libhwloc-dev \
  llvm-10 \
  llvm-10-dev \
  lsof \
  mlocate \
  ninja-build \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  pkg-config \
  software-properties-common \
  sudo \
  texinfo \
  time \
  tree \
  unzip \
  vim-nox \
  wget \
  zip \
  zlib1g-dev
