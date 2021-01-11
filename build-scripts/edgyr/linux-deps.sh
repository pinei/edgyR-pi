#! /bin/bash

set -e

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
  ffmpeg \
  file \
  flac \
  gdb \
  gfortran \
  git \
  git-lfs \
  gnupg \
  gstreamer1.0-alsa \
  gstreamer1.0-libav \
  gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-good \
  gstreamer1.0-plugins-bad \
  gstreamer1.0-plugins-ugly \
  gstreamer1.0-tools \
  ladspa-sdk \
  libasound2-dev \
  libavcodec-dev \
  libavdevice-dev \
  libavfilter-dev \
  libavformat-dev \
  libavresample-dev \
  libavutil-dev \
  libbz2-dev \
  libcairo2-dev \
  libc++-10-dev \
  libc++abi-10-dev \
  libclang-10-dev \
  libclang-common-10-dev \
  libclang-cpp10-dev \
  libclc-dev\
  libcurl4-gnutls-dev \
  libeigen3-dev \
  libffmpegthumbnailer-dev \
  libfftw3-dev \
  libfluidsynth-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libfuzzer-10-dev \
  libgit2-dev \
  libgmm++-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-good1.0-dev \
  libharfbuzz-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libhwloc-dev \
  libicu-dev \
  libjpeg8-dev \
  libjpeg-dev \
  libjpeg-turbo8-dev \
  liblld-10-dev \
  liblldb-10-dev \
  liblo-dev \
  liblttng-ust-dev \
  liblzma-dev \
  libmp3lame-dev \
  libncurses-dev \
  libnuma-dev \
  libomp-10-dev \
  libopenblas-dev \
  libopenmpi-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libpng-dev \
  libpostproc-dev \
  libpulse-dev \
  libreadline-dev \
  libsamplerate0-dev \
  libsdl-kitchensink-dev \
  libsndfile-dev \
  libsodium-dev \
  libsox-dev \
  libsox-fmt-all \
  libssh2-1-dev \
  libssl-dev \
  libstk0-dev \
  libswresample-dev \
  libswscale-dev \
  libtiff5-dev \
  libudunits2-dev \
  libwebsockets-dev \
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
  openmpi-bin \
  openmpi-common \
  openssh-client \
  pkg-config \
  portaudio19-dev \
  python \
  python3 \
  python-dev \
  python3-dev \
  python-pip \
  python3-pip \
  python-virtualenv \
  python3-virtualenv \
  python3-venv \
  software-properties-common \
  sox \
  stk \
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

echo "Adding 'ffmpeg-4' PPA"
add-apt-repository ppa:jonathonf/ffmpeg-4
echo "Updating to 'ffmpeg-4'"
apt-get update
apt-get -qqy --no-install-recommends dist-upgrade

apt-get clean