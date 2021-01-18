#! /bin/bash

set -e

mkdir --parents $HOME/Downloads/Installers
cd $HOME/Downloads/Installers
echo "Downloading Miniforge-pypy3 installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge-pypy3-Linux-aarch64.sh
chmod +x Miniforge-pypy3-Linux-aarch64.sh

echo "Installing a fresh copy to '$HOME/miniconda3' ..."
rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
./Miniforge-pypy3-Linux-aarch64.sh -b -p $HOME/miniconda3 \
  && rm ./Miniforge-pypy3-Linux-aarch64.sh

echo "Initializing conda for 'bash'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init bash
conda config --set auto_activate_base false

echo "Creating fresh 'r-reticulate' environment with JupyterLab and  dependencies for pyarrow, cupy, and cuSignal"
/usr/bin/time conda env create --quiet --force --file $EDGYR_SCRIPTS/r-reticulate.yml

conda activate r-reticulate
mkdir --parents $CONDA_PREFIX/src

echo "Cloning 'arrow' repository"
cd $CONDA_PREFIX/src
rm -fr arrow*
git clone https://github.com/apache/arrow.git

pushd arrow
git submodule init
git submodule update
export PARQUET_TEST_DATA="${PWD}/cpp/submodules/parquet-testing/data"
export ARROW_TEST_DATA="${PWD}/testing/data"
popd

echo "Patching arrow-cpp"
# see https://github.com/awthomp/rapids-jetson/blob/master/arrow.patch
diff \
  $EDGYR_SCRIPTS/CMakeLists.txt-cuda-patch \
  arrow/cpp/src/arrow/gpu/CMakeLists.txt || true
cp \
  $EDGYR_SCRIPTS/CMakeLists.txt-cuda-patch \
  arrow/cpp/src/arrow/gpu/CMakeLists.txt
diff \
  $EDGYR_SCRIPTS/CMakeLists.txt-cuda-patch \
  arrow/cpp/src/arrow/gpu/CMakeLists.txt

echo "Configuring arrow-cpp"
export ARROW_HOME=$CONDA_PREFIX
mkdir --parents arrow/cpp/build
pushd arrow/cpp/build
cmake -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DARROW_WITH_BZ2=ON \
      -DARROW_WITH_ZLIB=ON \
      -DARROW_WITH_ZSTD=ON \
      -DARROW_WITH_LZ4=ON \
      -DARROW_WITH_SNAPPY=ON \
      -DARROW_WITH_BROTLI=ON \
      -DARROW_CUDA=ON \
      -DARROW_PARQUET=ON \
      -DARROW_PYTHON=ON \
      -GNinja \
      .. >> $EDGYR_LOGS/pyarrow.log 2>&1

echo "Installing arrow-cpp"
/usr/bin/time ninja -j `nproc` >> $EDGYR_LOGS/pyarrow.log 2>&1
ninja install >> $EDGYR_LOGS/pyarrow.log 2>&1
popd

echo "Installing pyarrow"
pushd arrow/python
export PYARROW_WITH_CUDA=1
export PYARROW_WITH_PARQUET=1
/usr/bin/time python setup.py build_ext --inplace >> $EDGYR_LOGS/pyarrow.log 2>&1
echo "Testing pyarrow"
pytest --quiet pyarrow >> $EDGYR_LOGS/pyarrow.log 2>&1
gzip -9 $EDGYR_LOGS/pyarrow.log
popd

# see https://github.com/edgyR/edgyR-containers/issues/31,
# https://docs.cupy.dev/en/stable/reference/environment.html#for-installation,
# and https://developer.nvidia.com/cuda-gpus
echo "Installing 'cupy' - takes about 35 minutes on AGX Xavier"
export CUPY_NVCC_GENERATE_CODE="arch=compute_53,code=sm_53;arch=compute_62,code=sm_62;arch=compute_72,code=sm_72"
/usr/bin/time pip install 'cupy>=8.0.0' >> $EDGYR_LOGS/cupy.log 2>&1
gzip -9 $EDGYR_LOGS/cupy.log

echo "Installing 'cusignal'"
cd $CONDA_PREFIX/src
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
/usr/bin/time ./build.sh --allgpuarch >> $EDGYR_LOGS/cusignal.log 2>&1
gzip -9 $EDGYR_LOGS/cusignal.log
cp -rp $CUSIGNAL_HOME/notebooks $HOME/cusignal-notebooks

echo "Cleaning up"
conda clean --tarballs --index-cache --quiet --yes
conda list
