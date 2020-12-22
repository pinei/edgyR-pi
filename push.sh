#! /bin/bash

set -e

sudo docker push edgyr/internal-jetson-pocl:latest
sudo docker push edgyr/internal-libnode-dev:latest
sudo docker push edgyr/edgyr:latest
