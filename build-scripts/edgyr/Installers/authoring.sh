#! /bin/bash

set -e

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/authoring.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/authoring.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  libpng-dev \
  >> $EDGYR_LOGS/authoring.log 2>&1
echo "Installing R packages"
echo "This takes about 25 minutes on a 4 GB Nano"
echo "and 12 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/authoring.R')" \
  >> $EDGYR_LOGS/authoring.log 2>&1
