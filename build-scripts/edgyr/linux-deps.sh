#! /bin/bash

set -e

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  default-jdk-headless \
  file \
  gdb \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libpcre2-8-0 \
  libpq5 \
  lsof \
  mlocate \
  ninja-build \
  pkg-config \
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
  sudo \
  texinfo \
  time \
  tree \
  unzip \
  vim-nox \
  virtualenv \
  virtualenvwrapper \
  wget \
  zip \
  zlib1g-dev
update-alternatives --set editor /usr/bin/vim.nox


# RStudio uses 'soci' to connect to PostgreSQL and SQLite.
# However, the PostgreSQL client libraries in Bionic / L4t
# are for PostgreSQL 10, and won't work with newer versions.
# So we install the PostgreSQL Global Development Group
# (PGDG) repository.
echo "Installing PGDG Linux repository"
# https://wiki.postgresql.org/wiki/Apt
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo cp $SCRIPTS/pgdg.list /etc/apt/sources.list.d/pgdg.list

echo "Adding 'ffmpeg-4' PPA"
add-apt-repository ppa:jonathonf/ffmpeg-4

echo "Upgrading"
sudo apt-get update
sudo apt-get upgrade -y

echo "Installing ffmpeg-4"
apt-get install -qqy --no-install-recommends \
  ffmpeg
apt-get clean
