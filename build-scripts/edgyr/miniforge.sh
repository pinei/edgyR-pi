#! /bin/bash

set -e

mkdir --parents $HOME/Downloads/Installers
cd $HOME/Downloads/Installers
echo "Downloading Miniforge-pypy3 installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
chmod +x Miniforge3-Linux-aarch64.sh

echo "Installing a fresh copy to '$HOME/miniconda3' ..."
rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
./Miniforge3-Linux-aarch64.sh -b -p $HOME/miniconda3 \
  && rm ./Miniforge3-Linux-aarch64.sh

echo "Initializing conda for 'bash'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init bash
conda config --set auto_activate_base false

echo "Creating fresh 'r-reticulate' environment"
/usr/bin/time conda create --name r-reticulate --quiet --force --yes \
  numpy

echo "Cleaning up"
conda activate r-reticulate
conda clean --tarballs --index-cache --quiet --yes
conda list
