#! /bin/bash

set -e

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/audio.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/audio.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  flac \
  libfftw3-dev \
  libgdal-dev \
  libsox-fmt-all \
  libudunits2-dev \
  mp3splt \
  vlc \
  >> $EDGYR_LOGS/audio.log 2>&1
echo "Installing R packages"
echo "This takes about 29 minutes on a 4 GB Nano"
echo "and 14 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/audio.R')" \
  >> $EDGYR_LOGS/audio.log 2>&1
