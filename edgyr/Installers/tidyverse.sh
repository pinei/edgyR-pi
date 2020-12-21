#! /bin/bash

echo "Installing tidyverse Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev
echo "Installing tidyverse"
/usr/bin/time Rscript -e "source('~/Installers/R/tidyverse.R')"
