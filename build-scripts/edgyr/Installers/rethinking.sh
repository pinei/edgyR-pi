#! /bin/bash

set -e

echo "Installing R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/rethinking.R')" \
  >> $EDGYR_LOGS/rethinking.log
gzip -9 $EDGYR_LOGS/rethinking.log
