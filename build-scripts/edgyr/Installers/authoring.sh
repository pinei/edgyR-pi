#! /bin/bash

echo "Installing authoring packages"
/usr/bin/time Rscript -e "source('~/Installers/R/authoring.R')" >> $EDGYR_LOGS/authoring.log
