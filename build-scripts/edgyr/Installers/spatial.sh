#! /bin/bash

echo "Installing spatial Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev >> $EDGYR_LOGS/spatial.log
echo "Installing spatial R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/spatial.R')" >> $EDGYR_LOGS/spatial.log
