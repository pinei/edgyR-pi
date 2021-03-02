#! /bin/bash

set -e

# see https://github.com/edgyR/edgyR-containers/issues/31,
# https://docs.cupy.dev/en/stable/reference/environment.html#for-installation,
# and https://developer.nvidia.com/cuda-gpus
echo "Discovering CUDA capability"
$HOME/Installers/deviceQuery.sh \
  | grep -e "CUDA Capability Major/Minor version number:" \
  | sed 's;CUDA Capability Major/Minor version number:;;' \
  | sed 's;\s;;g' \
  | sed 's;\.;;' > /tmp/cuda_capability.txt
export CUDA_CAPABILITY=`cat /tmp/cuda_capability.txt`
export \
  CUPY_NVCC_GENERATE_CODE="arch=compute_$CUDA_CAPABILITY,code=sm_$CUDA_CAPABILITY"
echo $CUPY_NVCC_GENERATE_CODE
export CUPY_NUM_BUILD_JOBS=`nproc`

echo "Cloning 'cusignal'"
cd $PROJECT_HOME
export CUSIGNAL_VERSION=v0.18.0a
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
echo "Checking out version '$CUSIGNAL_VERSION'"
git checkout $CUSIGNAL_VERSION

echo "Creating fresh 'cusignal-dev' environment"
echo "This takes about 25 minutes on a 4 GB Nano"
echo "and 12 minutes on an AGX Xavier"
source $HOME/miniconda3/etc/profile.d/conda.sh
/usr/bin/time conda env create --quiet --force --file \
  conda/environments/cusignal_jetson_base.yml \
  >> $EDGYR_LOGS/cusignal-dev.log 2>&1

echo "Activating 'cusignal-dev'"
conda activate cusignal-dev

echo "Installing 'cusignal'"
export CUPY_NUM_BUILD_JOBS=`nproc`
/usr/bin/time ./build.sh \
  >> $EDGYR_LOGS/cusignal-dev.log 2>&1
echo "Copying '$CUSIGNAL_HOME/notebooks' to '$HOME/cusignal-notebooks'"
cp -rp $CUSIGNAL_HOME/notebooks $HOME/cusignal-notebooks

echo "Installing 'JupyterLab', 'pandas' and 'SymPy'"
/usr/bin/time conda install --quiet --yes \
  jupyterlab \
  pandas \
  sympy \
  >> $EDGYR_LOGS/cusignal-dev.log 2>&1

echo "Installing R package 'caracas'"
Rscript -e "install.packages('caracas', quiet = TRUE)" \
  >> $EDGYR_LOGS/cusignal-dev.log 2>&1

echo "Cleaning up"
conda clean --tarballs --index-cache --quiet --yes
conda list > $EDGYR_LOGS/cusignal-dev-conda-list.log
