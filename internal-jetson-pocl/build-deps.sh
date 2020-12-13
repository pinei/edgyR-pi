#! /bin/bash

set -e

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  build-essential \
  ca-certificates \
  clang-10 \
  clang-format-10 \
  clang-tidy-10 \
  clang-tools-10 \
  clinfo \
  cmake \
  gdb \
  git \
  libclang-10-dev \
  libclang-cpp10-dev \
  libfuzzer-10-dev \
  libhwloc-dev \
  liblld-10-dev \
  liblldb-10-dev \
  liblttng-ust-dev \
  libomp-10-dev \
  lld-10 \
  lldb-10 \
  llvm-10-dev \
  llvm-10 \
  llvm-10-runtime \
  llvm-10-tools \
  ninja-build \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  pkg-config \
  r-base-dev \
  vim-nox
