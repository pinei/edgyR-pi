#! /bin/bash

set -e

echo "Installing R packages"
echo "This takes about 23 minutes on an AGX Xavier"
echo "and 56 minutes on a 4 GB Nano"
/usr/bin/time Rscript -e "source('~/Installers/R/rethinking.R')" \
  >> $EDGYR_LOGS/rethinking.log 2>&1
gzip -9 $EDGYR_LOGS/rethinking.log
