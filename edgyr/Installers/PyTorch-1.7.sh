#! /bin/bash

echo "Installing PyTorch Linux dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev
echo "Creating fresh pytorch1.7 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
rm -fr $WORKON_HOME/pytorch1.7
virtualenv $WORKON_HOME/pytorch1.7 --python=/usr/bin/python3
source $WORKON_HOME/pytorch1.7/bin/activate
echo "Installing Python dependencies"
pip install \
  Cython \
  numpy
echo "Downloading PyTorch 1.7"
wget -q -nc \
  https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl \
  -O torch-1.7.0-cp36-cp36m-linux_aarch64.whl
echo "Installing PyTorch 1.7"
pip install torch-1.7.0-cp36-cp36m-linux_aarch64.whl
echo "Installing R rTorch package"
Rscript -e "install.packages('rTorch', quiet = TRUE)"
