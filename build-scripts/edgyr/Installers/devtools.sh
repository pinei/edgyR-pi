#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff5-dev \
  >> $EDGYR_LOGS/devtools.log
echo "Installing R packages"
Rscript -e "source('~/Installers/R/devtools.R')" \
  >> $EDGYR_LOGS/devtools.log
gzip -9 $EDGYR_LOGS/devtools.log
