#! /bin/bash

echo "Installing TensorFlow Linux dependencies"
sudo apt-get update
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
echo "Creating fresh tensorflow1 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
export TF_VENV=$WORKON_HOME/tensorflow1
rm -fr $TF_VENV
virtualenv $TF_VENV --python=/usr/bin/python3
source $TF_VENV/bin/activate
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
echo "Installing tensorflow 1"
/usr/bin/time pip install --extra-index-url \
  https://developer.download.nvidia.com/compute/redist/jp/v44 'tensorflow<2.0'
pip list

echo "Installing R keras package"
/usr/bin/time Rscript -e "source('~/Installers/R/keras.R')"
