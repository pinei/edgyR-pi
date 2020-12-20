#! /bin/bash

echo "Installing audio Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  flac \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libsndfile-dev \
  libsox-fmt-all \
  portaudio19-dev \
  sox
echo "Installing audio R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/audio.R')"
