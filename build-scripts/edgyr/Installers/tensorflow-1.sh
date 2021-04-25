#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e
rm -f $EDGYR_LOGS/tensorflow-1.log 2>&1

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
  numpy==1.19.4 \
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
/usr/bin/time pip install --extra-index-url \
  https://developer.download.nvidia.com/compute/redist/jp/v44 'tensorflow<2.0'  \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1

echo "Installing ipykernel"
pip install ipykernel \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1
python -m ipykernel install --name="tensorflow-1" \
  >> $EDGYR_LOGS/tensorflow-1.log 2>&1

pip list --format=columns > $EDGYR_LOGS/tensorflow-1-pip-list.log

echo "Finished"
