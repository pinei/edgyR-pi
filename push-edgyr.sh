#! /bin/bash

set -e

sudo docker push edgyr/edgyr:latest > $HOME/build-logs/push-edgyr.log 2>&1 &
sudo docker push edgyr/internal-rstudio-source:latest > $HOME/build-logs/push-internal-rstudio-source.log 2>&1 &
sudo docker push edgyr/internal-pandoc-source:latest > $HOME/build-logs/push-internal-pandoc-source.log 2>&1 &
sudo docker push edgyr/internal-r-source:latest > $HOME/build-logs/push-internal-r-source.log 2>&1 &
wait
