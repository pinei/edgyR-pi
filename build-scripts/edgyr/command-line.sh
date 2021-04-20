#! /bin/bash

set -e

echo "Installing command line tools"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  default-jdk-headless \
  file \
  gdb \
  gfortran \
  git \
  git-lfs \
  gnupg \
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
  zip
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

echo "Upgrading"
apt-get update
apt-get upgrade -y

echo "Installing SymPY"
pip3 install sympy

echo "Cleanup"
apt-get autoremove -y
apt-get clean
