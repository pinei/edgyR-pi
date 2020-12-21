#! /bin/bash

echo "Installing devtools and pkgdown Linux dependencies"
sudo apt-get update
sudo apt-get install -q --no-install-recommends \
  libcurl4-gnutls-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libpng-dev \
  libssh2-1-dev \
  libssl-dev \
  libtiff5-dev \
  libxml2-dev
echo "Installing devtools and pkgdown"
/usr/bin/time Rscript -e "source('~/Installers/R/devtools.R')"
