#! /bin/bash

set -e

echo "Installing PyTorch Linux dependencies"
sudo apt-get update
sudo apt-get install -qqy --no-install-recommends \
  libjpeg-dev \
  libopenblas-base \
  libopenmpi-dev \
  libpng-dev \
  libsox-dev \
  libsox-fmt-all \
  ninja-build \
  sox \
  zlib1g-dev
  
echo "Creating fresh pytorch1.7 virtualenv"
export WORKON_HOME=$HOME/.virtualenvs
export PYTORCH_VENV=$WORKON_HOME/pytorch1.7
rm -fr $PYTORCH_VENV
virtualenv $PYTORCH_VENV --python=/usr/bin/python3
source $PYTORCH_VENV/bin/activate
echo "Installing Python dependencies"
pip install \
  Cython \
  numpy \
  pillow
echo "Downloading PyTorch 1.7"
mkdir --parents $PYTORCH_VENV/src
pushd $PYTORCH_VENV/src
curl -Ls \
  https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl \
  > torch-1.7.0-cp36-cp36m-linux_aarch64.whl

echo "Installing PyTorch 1.7"
/usr/bin/time pip install torch-1.7.0-cp36-cp36m-linux_aarch64.whl

echo "Installing torchvision"
git clone -b v0.8.1 https://github.com/pytorch/vision.git torchvision
cd torchvision
python setup.py install
cd ..

echo "Installing torchaudio"
git clone -b v0.7.0  https://github.com/pytorch/audio torchaudio
cd torchaudio
python setup.py install
cd ..

popd

pip list

echo "Installing R rTorch package"
rm -fr $HOME/Installers/R/datasets
/usr/bin/time Rscript -e "source('~/Installers/R/rTorch.R')"
