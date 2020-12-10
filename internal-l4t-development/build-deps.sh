#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  clang-10 \
  clang-format-10 \
  clang-tidy-10 \
  clang-tools-10 \
  clinfo \
  cmake \
  curl \
  file \
  git \
  git-lfs \
  gnupg \
  libclang-10-dev \
  libclang-cpp10-dev \
  libfuzzer-10-dev \
  libhwloc-dev \
  liblld-10-dev \
  liblldb-10-dev \
  libomp-10-dev \
  lld-10 \
  lldb-10 \
  llvm-10-dev \
  llvm-10 \
  llvm-10-runtime \
  llvm-10-tools \
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
