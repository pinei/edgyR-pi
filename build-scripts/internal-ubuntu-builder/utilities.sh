#! /bin/bash

set -e

echo "Installing Linux packages"
apt-get install -qqy --no-install-recommends \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libsodium-dev \
  libssl-dev \
  libxml2-dev
echo "Installing R packages"
/usr/bin/time $SCRIPTS/utilities.R
