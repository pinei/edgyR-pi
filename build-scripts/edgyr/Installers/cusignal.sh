#! /bin/bash

set -e

echo "Creating fresh 'cusignal' environment with JupyterLab and cuSignal dependencies"
source $HOME/miniconda3/etc/profile.d/conda.sh
/usr/bin/time conda env create --quiet --force --file $HOME/Installers/etc/cusignal.yml
conda activate cusignal

# see https://github.com/edgyR/edgyR-containers/issues/31,
# https://docs.cupy.dev/en/stable/reference/environment.html#for-installation,
# and https://developer.nvidia.com/cuda-gpus
echo "Installing 'cupy' - takes about 50 minutes on AGX Xavier"
export CUPY_NVCC_GENERATE_CODE="arch=compute_53,code=sm_53;arch=compute_62,code=sm_62;arch=compute_72,code=sm_72"
export CUPY_NUM_BUILD_JOBS=`nproc`
/usr/bin/time pip install -v 'cupy>=8.0.0' >> $EDGYR_LOGS/cupy.log 2>&1
gzip -9 $EDGYR_LOGS/cupy.log 2>&1

echo "Installing 'cusignal'"
cd $CONDA_PREFIX
mkdir --parents src; cd src
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
/usr/bin/time ./build.sh --allgpuarch >> $EDGYR_LOGS/cusignal.log 2>&1
gzip -9 $EDGYR_LOGS/cusignal.log 2>&1
cp -rp $CUSIGNAL_HOME/notebooks $HOME/cusignal-notebooks

echo "Cleaning up"
conda clean --tarballs --index-cache --quiet --yes
conda list

echo "Enabling JupyterLab start"
cp $HOME/Installers/etc/start-jupyter-lab.sh $HOME
