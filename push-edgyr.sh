#! /bin/bash

set -e

sudo docker push edgyr/edgyr-ml:latest > /tmp/push-edgyr-ml_latest.log 2>&1 &
sudo docker push edgyr/internal-rstudio-source:latest > /tmp/push-internal-rstudio-source_latest.log 2>&1 &
sudo docker push edgyr/internal-pandoc-source:latest > /tmp/push-internal-pandoc-source_latest.log 2>&1 &
sudo docker push edgyr/internal-r-source:latest > /tmp/push-internal-r-source_latest.log 2>&1 &
wait
