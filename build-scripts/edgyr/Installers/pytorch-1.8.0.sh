#! /bin/bash

echo "Installing PyTorch Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
echo "Creating fresh pytorch-1.8.0 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
export PT_VENV=$WORKON_HOME/pytorch-1.8.0
rm -fr $PT_VENV
virtualenv $PT_VENV --python=/usr/bin/python3
source $PT_VENV/bin/activate
echo "Installing Python dependencies"
echo "This takes about 7 minutes on an AGX Xavier"
/usr/bin/time pip install Cython \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
wget --quiet \
  -O torch-1.8.0-cp36-cp36m-linux_aarch64.whl \
  https://nvidia.box.com/shared/static/p57jwntv436lfrd78inwl7iml6p13fzh.whl
/usr/bin/time pip install -U \
  numpy \
  torch-1.8.0-cp36-cp36m-linux_aarch64.whl \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
pip list --format=columns > $EDGYR_LOGS/pytorch-1.8.0-pip-list.log
