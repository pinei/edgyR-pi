#! /bin/bash

echo "Installing spatial Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  librasterlite2-dev \
  libspatialite-dev \
  libudunits2-dev \
  rasterlite2-bin \
  spatialite-bin \
  >> $EDGYR_LOGS/spatial.log 2>&1
echo "Installing spatial R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/spatial.R')" \
  >> $EDGYR_LOGS/spatial.log 2>&1
