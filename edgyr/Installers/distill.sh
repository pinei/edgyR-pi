#! /bin/bash

echo "Installing distill Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  libpng-dev \
  libssl-dev \
  libxml2-dev
echo "Installing distill"
Rscript -e "install.packages('distill', quiet = TRUE)"
