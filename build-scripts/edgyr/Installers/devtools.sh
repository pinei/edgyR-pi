#! /bin/bash

set -e

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/devtools.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/devtools.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff5-dev \
  >> $EDGYR_LOGS/devtools.log 2>&1
echo "Installing R packages"
echo "This takes about 10 minutes on a 4 GB Nano"
echo "and 5.5 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/devtools.R')" \
  >> $EDGYR_LOGS/devtools.log 2>&1
