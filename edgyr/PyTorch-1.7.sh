#! /bin/bash

set -e

export PT=$SOURCE_DIR/PyTorch-1.7
rm -fr $PT; mkdir --parents $PT; pushd $PT

echo "Installing Python dependencies"
pip3 install \
  Cython \
  setuptools \
  wheel
pip3 install \
  numpy \
  pillow

echo "Downloading PyTorch 1.7"
curl -Ls \
  https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl \
  > torch-1.7.0-cp36-cp36m-linux_aarch64.whl

echo "Installing PyTorch 1.7"
/usr/bin/time pip3 install torch-1.7.0-cp36-cp36m-linux_aarch64.whl

echo "Installing torchvision"
git clone -b v0.8.1 https://github.com/pytorch/vision.git torchvision
cd torchvision
python3 setup.py install
cd ..

echo "Installing torchaudio"
git clone -b v0.7.0  https://github.com/pytorch/audio torchaudio
cd torchaudio
python3 setup.py install
cd ..

popd

pip3 list --format=columns
python3 $SCRIPTS/test-pytorch.py

rm -fr $PT
