#! /bin/bash

set -e

sudo docker push edgyr/l4t-ml:r32.4.4-py3 > $HOME/build-logs/push-l4t-ml_r32.4.4-py3.log 2>&1 &
sudo docker push edgyr/l4t-ml:r32.4.4-tf1.15-py3 > $HOME/build-logs/push-l4t-ml_r32.4.4-tf1.15-py3.log 2>&1 &
sudo docker push edgyr/l4t-ml:r32.4.4-tf2.3-py3 > $HOME/build-logs/push-l4t-ml_r32.4.4-tf2.3-py3.log 2>&1 &
sudo docker push edgyr/l4t-tensorflow:r32.4.4-tf2.3-py3 > $HOME/build-logs/push-l4t-tensorflow_r32.4.4-tf2.3-py3.log 2>&1 &
sudo docker push edgyr/l4t-tensorflow:r32.4.4-tf1.15-py3 > $HOME/build-logs/push-l4t-tensorflow_r32.4.4-tf1.15-py3.log 2>&1 &
sudo docker push edgyr/l4t-pytorch:r32.4.4-pth1.6-py3 > $HOME/build-logs/push-l4t-pytorch_r32.4.4-pth1.6-py3.log 2>&1 &
wait
