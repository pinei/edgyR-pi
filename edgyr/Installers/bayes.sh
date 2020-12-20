#! /bin/bash

echo "Installing Bayesian analysis R packages"
/usr/bin/time Rscript -e "source('~/Installers/R/bayes.R')"
