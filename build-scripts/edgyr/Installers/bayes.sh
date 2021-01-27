#! /bin/bash

echo "Installing bayes R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/bayes.R')" \
  >> $EDGYR_LOGS/bayes.log 2>&1
