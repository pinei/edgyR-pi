#! /bin/bash

set -e

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/spatial.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/spatial.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev \
  >> $EDGYR_LOGS/spatial.log 2>&1
echo "Installing R packages"
echo "This takes about 29 minutes on an AGX Xavier"
echo "and 1 hour on a 4 GB Nano"
/usr/bin/time Rscript -e "source('~/Installers/R/spatial.R')" \
  >> $EDGYR_LOGS/spatial.log 2>&1
