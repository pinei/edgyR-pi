#! /bin/bash

echo "Installing audio Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  flac \
  libfftw3-dev \
  libsndfile-dev \
  libsox-fmt-all \
  portaudio19-dev \
  sox
echo "Installing audio R packages"
Rscript -e "source('~/Installers/audio.R')"
