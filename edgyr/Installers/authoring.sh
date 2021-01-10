#! /bin/bash

echo "Installing authoring packages"
/usr/bin/time Rscript -e "source('~/Installers/R/authoring.R')" >> $HOME/logs/authoring.log
