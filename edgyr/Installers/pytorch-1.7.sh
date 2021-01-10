#! /bin/bash

set -e

echo "Creating fresh pytorch-1.7 virtualenv"
export PT_VENV=$WORKON_HOME/pytorch-1.7
rm -fr $PT_VENV
virtualenv $PT_VENV --python=/usr/bin/python3
source $PT_VENV/bin/activate
mkdir --parents $PT_VENV/src
pushd $PT_VENV/src

echo "Installing Python dependencies"
/usr/bin/time pip install Cython >> $HOME/logs/pytorch-1.7.log 2>&1

# see https://github.com/numpy/numpy/issues/18131
/usr/bin/time pip install \
  "numpy<=1.19.4" \
  pillow >> $HOME/logs/pytorch-1.7.log 2>&1

echo "Downloading PyTorch 1.7"
curl -Ls \
  https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl \
  > torch-1.7.0-cp36-cp36m-linux_aarch64.whl

echo "Installing PyTorch 1.7"
/usr/bin/time pip install --no-cache-dir torch-1.7.0-cp36-cp36m-linux_aarch64.whl >> $HOME/logs/pytorch-1.7.log 2>&1

echo "Installing torchvision"
git clone -b v0.8.1 https://github.com/pytorch/vision.git torchvision
cd torchvision
/usr/bin/time python setup.py install >> $HOME/logs/pytorch-1.7.log 2>&1
cd ..

echo "Installing torchaudio"
git clone -b v0.7.0  https://github.com/pytorch/audio torchaudio
cd torchaudio
/usr/bin/time python setup.py install >> $HOME/logs/pytorch-1.7.log 2>&1
cd ..

popd

pip list --format=columns >> $HOME/logs/pytorch-1.7.log 2>&1

echo "Testing PyTorch with Python"
/usr/bin/time python $EDGYR_HOME/Installers/test-pytorch.py >> $HOME/logs/pytorch-1.7.log 2>&1

echo "Installing R package 'rTorch'"
/usr/bin/time Rscript -e "install.packages('rTorch', quiet = TRUE)" >> $HOME/logs/pytorch-1.7.log 2>&1
