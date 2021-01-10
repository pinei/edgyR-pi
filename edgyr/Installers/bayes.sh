#! /bin/bash

echo "Installing bayes R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/bayes.R')" >> $HOME/logs/bayes.log
