#! /bin/bash

set -e

apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  command-not-found \
  command-not-found-data \
  python3-commandnotfound \
  packagekit-command-not-found \
  file \
  git \
  git-lfs \
  mlocate \
  software-properties-common \
  time \
  tree \
  unzip \
  vim-nox \
  zip

# allow fetching sources from main repos
cp $SCRIPTS/sources.list.new /etc/apt/sources.list

# connect to the PPA
add-apt-repository ppa:savoury1/haskell-build

# allow source from the PPA
sed -i 's/^\# deb-src/deb-src/' /etc/apt/sources.list.d/savoury1-ubuntu-haskell-build-bionic.list

# update
apt-get update
