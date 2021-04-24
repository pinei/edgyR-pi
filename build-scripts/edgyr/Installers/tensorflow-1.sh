#! /bin/bash

echo "Installing TensorFlow Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/tensorflow-1.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/tensorflow-1.log 2>&1
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  gfortran \
  hdf5-tools \
  libblas-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libjpeg8-dev \
  liblapack-dev \
  zip \
  zlib1g-dev \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1
echo "Creating fresh tensorflow-1 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
export TF_VENV=$WORKON_HOME/tensorflow-1
rm -fr $TF_VENV
virtualenv $TF_VENV --python=/usr/bin/python3
source $TF_VENV/bin/activate
echo "Installing Python dependencies"
echo "This takes about 7 minutes on an AGX Xavier"
/usr/bin/time pip install Cython \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1
/usr/bin/time pip install -U \
  absl-py \
  astor \
  gast \
  google-pasta \
  grpcio \
  h5py \
  keras-applications \
  keras-preprocessing \
  mock \
  numpy \
  portpicker \
  protobuf \
  psutil \
  py-cpuinfo \
  requests \
  setuptools \
  six \
  termcolor \
  testresources \
  wrapt \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1
echo "Installing tensorflow 1"
echo "This takes about 6 minutes on an AGX Xavier"
/usr/bin/time pip install --extra-index-url \
  https://developer.download.nvidia.com/compute/redist/jp/v44 'tensorflow<2.0'  \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1
pip list --format=columns > $EDGYR_LOGS/tensorflow-1-pip-list.log
