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
rm -f $EDGYR_LOGS/tensorflow-2.log 2>&1

echo "Installing TensorFlow Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  gfortran \
  hdf5-tools \
  libblas-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  libjpeg8-dev \
  liblapack-dev \
  protobuf-compiler \
  zip \
  zlib1g-dev \
  >> $EDGYR_LOGS/tensorflow-2.log 2>&1

echo "Creating fresh tensorflow-2 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
export TF_VENV=$WORKON_HOME/tensorflow-2
rm -fr $TF_VENV
virtualenv $TF_VENV --python=/usr/bin/python3 \
  >> $EDGYR_LOGS/tensorflow-2.log 2>&1
source $TF_VENV/bin/activate

echo "Installing Python dependencies"
/usr/bin/time pip install -U \
  numpy==1.19.4 \
  future==0.18.2 \
  mock==3.0.5 \
  h5py==2.10.0 \
  keras_preprocessing==1.1.1 \
  keras_applications==1.0.8 \
  gast==0.2.2 \
  futures \
  protobuf \
  pybind11 \
  >> $EDGYR_LOGS/tensorflow-2.log 2>&1

echo "Installing tensorflow 2"
/usr/bin/time pip install --extra-index-url \
  https://developer.download.nvidia.com/compute/redist/jp/v45 'tensorflow>1.99'  \
  >> $EDGYR_LOGS/tensorflow-2.log 2>&1

pushd $PROJECT_HOME

  echo "Cloning onnx"
  rm -fr onnx*
  git clone https://github.com/onnx/onnx.git \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1
  cd onnx
  git submodule update --init --recursive \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1
  git checkout v1.9.0 \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1

  echo "Installing onnx"
  python setup.py install \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1
  cd ..

  echo "Cloning tensorflow-onnx"
  rm -fr tensorflow-onnx*
  git clone https://github.com/onnx/tensorflow-onnx.git \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1
  cd tensorflow-onnx
  git checkout v1.8.4 \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1

  echo "Installing tensorflow-onnx"
  python setup.py install \
    >> $EDGYR_LOGS/tensorflow-2.log 2>&1
  cd ..

  popd

echo "Installing ipykernel"
pip install ipykernel \
  >> $EDGYR_LOGS/tensorflow-2.log 2>&1
python -m ipykernel install --user --name="tensorflow-2" \
  >> $EDGYR_LOGS/tensorflow-2.log 2>&1

pip list --format=columns > $EDGYR_LOGS/tensorflow-2-pip-list.log

echo "Finished"
