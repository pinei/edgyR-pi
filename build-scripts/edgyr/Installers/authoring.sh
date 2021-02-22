#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  libpng-dev \
  >> $EDGYR_LOGS/authoring.log
echo "Installing R packages"
Rscript -e "source('~/Installers/R/authoring.R')" \
  >> $EDGYR_LOGS/authoring.log
gzip -9 $EDGYR_LOGS/authoring.log
