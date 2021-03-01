#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  libpng-dev \
  >> $EDGYR_LOGS/authoring.log
echo "Installing R packages"
echo "This takes about 7 minutes on a 4 GB Nano"
echo "and 12 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/authoring.R')" \
  >> $EDGYR_LOGS/authoring.log
gzip -9 $EDGYR_LOGS/authoring.log
