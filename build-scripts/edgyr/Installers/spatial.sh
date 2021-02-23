#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev \
  >> $EDGYR_LOGS/spatial.log
echo "Installing R packages"
echo "This takes about 17 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/spatial.R')" \
  >> $EDGYR_LOGS/spatial.log
gzip -9 $EDGYR_LOGS/spatial.log
