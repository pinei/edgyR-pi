#! /bin/bash

set -e

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  bison \
  build-essential \
  ca-certificates \
  clang-10 \
  clang-format-10 \
  clang-tidy-10 \
  clang-tools-10 \
  clinfo \
  cmake \
  curl \
  flex \
  gdb \
  git \
  ladspa-sdk \
  libclang-10-dev \
  libclang-cpp10-dev \
  libcurl4-gnutls-dev \
  libeigen3-dev \
  libfluidsynth-dev \
  libfuzzer-10-dev \
  libgmm++-dev \
  libhwloc-dev \
  liblld-10-dev \
  liblldb-10-dev \
  liblo-dev \
  liblttng-ust-dev \
  libmp3lame-dev \
  libomp-10-dev \
  libpulse-dev \
  libsamplerate0-dev \
  libsndfile-dev \
  libstk0-dev \
  libwebsockets-dev \
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
  portaudio19-dev \
  python-dev \
  r-base-dev \
  swig3.0 \
  vim-nox \
  wget
