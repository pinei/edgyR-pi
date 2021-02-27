#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  libpq-dev \
  unixodbc-dev \
  >> $EDGYR_LOGS/tidyverse.log
echo "Installing R packages"
echo "This takes about 5 minutes on a 4 GB Nano"
echo "and 3 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/tidyverse.R')" \
  >> $EDGYR_LOGS/tidyverse.log
gzip -9 $EDGYR_LOGS/tidyverse.log
