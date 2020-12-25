#! /bin/bash

set -e

mkdir --parents $HOME/Downloads/Installers
cd $HOME/Downloads/Installers
echo "Downloading Mambaforge-pypy3 installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-pypy3-Linux-aarch64.sh
chmod +x Mambaforge-pypy3-Linux-aarch64.sh

echo "Installing a fresh copy to '$HOME/miniconda3' ..."
rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
./Mambaforge-pypy3-Linux-aarch64.sh -b -p $HOME/miniconda3 \
  && rm ./Mambaforge-pypy3-Linux-aarch64.sh

echo "Initializing conda for 'bash'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init bash
conda config --set auto_activate_base false

echo "Creating fresh 'r-reticulate' environment with Python 3.6 and PyArrow CPU-only"
conda env remove --name r-reticulate --yes
conda create --quiet --name r-reticulate --yes \
  pyarrow \
  python=3.6
export PKG_CONFIG_PATH=$EDGYR_HOME/miniconda3/envs/r-reticulate/lib/pkgconfig:$PKG_CONFIG_PATH
export R_LD_LIBRARY_PATH=$EDGYR_HOME/miniconda3/envs/r-reticulate/lib:$R_LD_LIBRARY_PATH
/usr/bin/time Rscript -e "source('~/scripts/install-arrow.R')"
