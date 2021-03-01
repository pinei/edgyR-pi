#! /bin/bash

set -e

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  libpq-dev \
  unixodbc-dev \
  >> $EDGYR_LOGS/tidyverse.log 2>&1
echo "Installing R packages"
echo "This takes about 21 minutes on a 4 GB Nano"
echo "and 11 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/tidyverse.R')" \
  >> $EDGYR_LOGS/tidyverse.log 2>&1
gzip -9 $EDGYR_LOGS/tidyverse.log
