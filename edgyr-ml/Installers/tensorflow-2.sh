#! /bin/bash

echo "Installing tensorflow dependencies"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -qqy --no-install-recommends \
  gfortran \
  hdf5-tools \
  libblas-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libjpeg8-dev \
  liblapack-dev \
  zip \
  zlib1g-dev
echo "Creating fresh tensorflow-2 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
rm -fr $WORKON_HOME/tensorflow2
virtualenv $WORKON_HOME/tensorflow2 --python=/usr/bin/python3
source $WORKON_HOME/tensorflow2/bin/activate
echo "Installing Python dependencies"
pip install -U \
  future==0.18.2 \
  futures \
  gast==0.2.2 \
  h5py==2.10.0 \
  keras_applications==1.0.8 \
  keras_preprocessing==1.1.1 \
  mock==3.0.5 \
  numpy==1.16.1 \
  protobuf \
  pybind11
echo "Installing tensorflow 2"
pip install --extra-index-url \
  https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow
echo "Installing R keras package"
Rscript -e "install.packages('keras', quiet = TRUE)"
echo "Testing keras on mnist"
Rscript -e "source('~/Installers/test-keras.R')"
