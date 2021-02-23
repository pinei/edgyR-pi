#! /bin/bash

set -e

echo "Installing R packages"
echo "This takes about 11 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/rethinking.R')" \
  >> $EDGYR_LOGS/rethinking.log
gzip -9 $EDGYR_LOGS/rethinking.log
