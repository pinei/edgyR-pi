#! /bin/bash

set -e

sudo docker push edgyr/internal-jetson-pocl:latest
sudo docker push edgyr/internal-libnode-dev:latest
sudo docker push edgyr/l4t-pytorch:r32.4.4-pth1.7-py3
sudo docker push edgyr/edgyr:latest
