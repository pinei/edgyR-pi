#! /bin/bash

echo "Installing PGDG Linux repository"
# https://wiki.postgresql.org/wiki/Apt
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo cp $HOME/Installers/etc/pgdg.list /etc/apt/sources.list.d/pgdg.list
echo "Installing spatial Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev >> $EDGYR_LOGS/spatial.log
echo "Installing spatial R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/spatial.R')" >> $EDGYR_LOGS/spatial.log
