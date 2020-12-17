#! /bin/bash

echo "Installing Linux dependencies"
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
  default-jdk-headless \
  file \
  flac \
  gdb \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libbz2-dev \
  libcairo2-dev \
  libclang-10-dev \
  libclang-cpp10-dev \
  libclc-dev\
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libfuzzer-10-dev \
  libharfbuzz-dev \
  libhwloc-dev \
  libicu-dev \
  libjpeg8-dev \
  libjpeg-dev \
  libjpeg-turbo8-dev \
  liblld-10-dev \
  liblldb-10-dev \
  liblttng-ust-dev \
  liblzma-dev \
  libncurses-dev \
  libnuma-dev \
  libomp-10-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libpng-dev \
  libreadline-dev \
  libsndfile-dev \
  libsodium-dev \
  libsox-dev \
  libsox-fmt-all \
  libssh2-1-dev \
  libssl-dev \
  libtiff5-dev \
  libudunits2-dev \
  libxml2-dev \
  libxmu-dev \
  lld-10 \
  lldb-10 \
  llvm-10 \
  llvm-10-dev \
  llvm-10-runtime \
  llvm-10-tools \
  lsof \
  mlocate \
  ninja-build \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  opencl-c-headers\
  opencl-clhpp-headers\
  opencl-headers \
  openssh-client \
  pkg-config \
  portaudio19-dev \
  python \
  python3 \
  python3-dev \
  python3-venv \
  python3-virtualenv \
  python-dev \
  python-virtualenv \
  software-properties-common \
  sox \
  sudo \
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  vim-nox \
  virtualenv \
  virtualenvwrapper \
  wget \
  zip \
  zlib1g-dev
update-alternatives --set editor /usr/bin/vim.nox

# install libnode-dev and dependencies packages
pushd /usr/local/src/packages
apt-get install -qqy --no-install-recommends \
  ./libnghttp2-14_*.deb \
  ./libuv1_*.deb \
  ./libuv1-dev_*.deb \
  ./libnode64_*.deb \
  ./libnode-dev_*.deb
popd

apt-get clean
