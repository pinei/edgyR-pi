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
rm -fr $EDGYR_LOGS/pytorch-1.8.0.log

echo "Installing PyTorch Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  libopenblas-base \
  libopenmpi-dev \
  libsox-dev \
  libsox-fmt-all \
  protobuf-compiler \
  python3-pybind11 \
  sox \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

echo "Creating fresh pytorch-1.8.0 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
export PT_VENV=$WORKON_HOME/pytorch-1.8.0
rm -fr $PT_VENV
virtualenv $PT_VENV --python=/usr/bin/python3 \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
source $PT_VENV/bin/activate

echo "Installing Python dependencies"
/usr/bin/time pip install -U \
  Cython \
  numpy==1.19.4 \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

echo "Downloading PyTorch"
wget --quiet \
  -O torch-1.8.0-cp36-cp36m-linux_aarch64.whl \
  https://nvidia.box.com/shared/static/p57jwntv436lfrd78inwl7iml6p13fzh.whl

echo "Installing PyTorch"
/usr/bin/time pip install -U \
  torch-1.8.0-cp36-cp36m-linux_aarch64.whl \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
rm torch-1.8.0-cp36-cp36m-linux_aarch64.whl
pushd $PROJECT_HOME

  echo "Cloning torchaudio"
  rm -fr audio
  git clone https://github.com/pytorch/audio.git \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  cd audio
  git submodule update --init --recursive \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  git checkout v0.8.0 \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

  echo "Installing torchaudio"
  BUILD_SOX=0 python setup.py install \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  cd ..

  echo "Cloning onnx"
  rm -fr onnx*
  git clone https://github.com/onnx/onnx.git \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  cd onnx
  git submodule update --init --recursive \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  git checkout v1.9.0 \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

  echo "Installing onnx"
  python setup.py install \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  cd ..

  echo "Cloning torchvision"
  rm -fr vision
  git clone https://github.com/pytorch/vision.git \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  cd vision
  git checkout v0.9.0 \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

  echo "Installing torchvision"
  python setup.py install \
    >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1
  cd ..

  popd

echo "Installing ipykernel"
pip install ipykernel \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

python -m ipykernel install --user --name="pytorch-1.8.0" \
  >> $EDGYR_LOGS/pytorch-1.8.0.log 2>&1

pip list --format=columns > $EDGYR_LOGS/pytorch-1.8.0-pip-list.log

echo "Finished"
