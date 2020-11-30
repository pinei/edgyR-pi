#! /bin/bash

echo "Installing devtools dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libpng-dev \
  libssh2-1-dev \
  libssl-dev \
  libtiff5-dev \
  libxml2-dev
echo "Installing devtools dependencies"
Rscript -e "install.packages(c('devtools', 'pkgdown'), quiet = TRUE)"
