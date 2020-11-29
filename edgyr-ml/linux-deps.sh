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
  flac \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libbz2-dev \
  libcairo2-dev \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfribidi-dev \
  libgmp-dev \
  libharfbuzz-dev \
  libicu-dev \
  libjpeg8-dev \
  libjpeg-turbo8-dev \
  liblzma-dev \
  libncurses-dev \
  libnuma-dev \
  libpam-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libprotobuf-dev \
  libreadline-dev \
  libsndfile-dev \
  libsodium-dev \
  libsox-fmt-all \
  libssh2-1-dev \
  libssl-dev \
  libtiff5-dev \
  libxml2-dev \
  libzstd-dev \
  lsof \
  mlocate \
  openssh-client \
  pkg-config \
  portaudio19-dev \
  protobuf-compiler \
  python \
  python3 \
  python-dev \
  python3-dev \
  python3-venv \
  python-virtualenv \
  python3-virtualenv \
  software-properties-common \
  sox \
  sudo \
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  uuid-dev \
  vim-nox \
  virtualenv \
  virtualenvwrapper \
  wget \
  zip \
  zlib1g-dev

echo ""
echo "Installing spatial dependencies"
# https://wiki.postgresql.org/wiki/Apt
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev
update-alternatives --set editor /usr/bin/vim.nox
apt-get clean
