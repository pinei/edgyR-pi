#! /bin/bash

set -e

sudo docker push edgyr/edgyr:latest
sudo docker push edgyr/internal-rstudio-server:latest
sudo docker push edgyr/internal-r:latest
sudo docker push edgyr/internal-pandoc:latest
sudo docker push edgyr/internal-ghc-8.6:latest
sudo docker push edgyr/internal-cabal-3.2:latest
sudo docker push edgyr/internal-cabal-3.0:latest
sudo docker push edgyr/internal-ghc-8.2:latest
sudo docker push edgyr/internal-build-dependencies:latest
