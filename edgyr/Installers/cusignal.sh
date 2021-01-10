#! /bin/bash

set -e

echo "Activating 'r-reticulate' conda env"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate

echo "Installing 'cusignal'"
cd $CONDA_PREFIX
mkdir --parents src; cd src
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
/usr/bin/time ./build.sh --allgpuarch >> $HOME/logs/cusignal.log 2>&1
cp -rp $CUSIGNAL_HOME/notebooks $HOME/cusignal-notebooks
