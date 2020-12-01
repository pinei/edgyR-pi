#! /bin/bash

echo "Installing tidyverse Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev
echo "Installing tidyverse"
Rscript -e "install.packages('tidyverse', quiet = TRUE)"