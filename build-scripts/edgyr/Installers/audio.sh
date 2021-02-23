#! /bin/bash

set -e

echo "Installing Linux packages"
sudo apt-get install -qqy --no-install-recommends \
  flac \
  libfftw3-dev \
  libgdal-dev \
  libsox-fmt-all \
  libudunits2-dev \
  mp3splt \
  vlc \
  >> $EDGYR_LOGS/audio.log
echo "Installing R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/audio.R')" \
  >> $EDGYR_LOGS/audio.log
gzip -9 $EDGYR_LOGS/audio.log
