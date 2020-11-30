#! /bin/bash

set -e

sudo docker push edgyr/edgyr:latest > /tmp/push-edgyr.log 2>&1 &
sudo docker push edgyr/internal-rstudio-source:latest > /tmp/push-internal-rstudio-source.log 2>&1 &
sudo docker push edgyr/internal-pandoc-source:latest > /tmp/push-internal-pandoc-source.log 2>&1 &
sudo docker push edgyr/internal-r-source:latest > /tmp/push-internal-r-source.log 2>&1 &
wait
