#! /bin/bash

echo "Installing distill Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  libpng-dev \
  libssl-dev \
  libxml2-dev
echo "Installing distill"
/usr/bin/time Rscript -e "source('~/Installers/R/distill.R')"
