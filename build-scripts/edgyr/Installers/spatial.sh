#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev \
  >> $EDGYR_LOGS/spatial.log
echo "Installing R packages"
Rscript -e "source('~/Installers/R/spatial.R')" \
  >> $EDGYR_LOGS/spatial.log
gzip -9 $EDGYR_LOGS/spatial.log
