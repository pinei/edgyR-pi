#! /bin/bash

set -e

#echo "Installing Linux packages"
#apt-get install -qqy --no-install-recommends \
  #libfontconfig1-dev \
  #libfreetype6-dev \
  #libfribidi-dev \
  #libgit2-dev \
  #libharfbuzz-dev \
  #libjpeg-dev \
  #libpng-dev \
  #libtiff5-dev
echo "Installing R packages"
/usr/bin/time $SCRIPTS/devtools.R
