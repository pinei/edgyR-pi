#! /bin/bash

set -e

sudo docker pull edgyr/internal-jetson-pocl:latest
sudo docker pull edgyr/internal-libnode-dev:latest
sudo docker pull edgyr/l4t-pytorch:r32.4.4-pth1.7-py3
sudo docker pull edgyr/edgyr:latest
