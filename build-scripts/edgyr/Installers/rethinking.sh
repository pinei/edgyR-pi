#! /bin/bash

set -e

echo "Installing R packages"
echo "This takes about 23 minutes on an AGX Xavier"
echo "and 1 hour 21 minutes on a 4 GB Nano"
/usr/bin/time Rscript -e "source('~/Installers/R/rethinking.R')" \
  > $EDGYR_LOGS/rethinking.log 2>&1
