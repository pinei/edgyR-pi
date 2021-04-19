#! /bin/bash

set -e

echo "Installing build dependencies"
sudo apt-get install -qqy --no-install-recommends \
  phantomjs
$EDGYR_SCRIPTS/r-packages.R
