#! /bin/bash

set -e

echo "Installing build dependencies"
sudo apt-get install -qqy --no-install-recommends \
  flac \
  libfftw3-dev \
  libfontconfig1-dev \
  libfribidi-dev \
  libgdal-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libpcre2-8-0 \
  libsodium-dev \
  libsox-fmt-all \
  libudunits2-dev \
  mp3splt \
  phantomjs \
  vlc
$EDGYR_SCRIPTS/r-packages.R
