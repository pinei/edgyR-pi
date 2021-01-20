#! /bin/bash

set -e

rm -f $EDGYR_LOGS/pyarrow.log

echo "Cloning arrow repository"
cd $PROJECT_HOME
rm -fr arrow
git clone https://github.com/apache/arrow.git
pushd arrow
git submodule init
git submodule update
export PARQUET_TEST_DATA="${PWD}/cpp/submodules/parquet-testing/data"
export ARROW_TEST_DATA="${PWD}/testing/data"

# see https://github.com/awthomp/rapids-jetson/blob/master/arrow.patch
echo "Patching arrow-cpp"
diff \
  $HOME/Installers/etc/CMakeLists.txt-cuda-patch \
  cpp/src/arrow/gpu/CMakeLists.txt || true
cp \
  $HOME/Installers/etc/CMakeLists.txt-cuda-patch \
  cpp/src/arrow/gpu/CMakeLists.txt
diff \
  $HOME/Installers/etc/CMakeLists.txt-cuda-patch \
  cpp/src/arrow/gpu/CMakeLists.txt
popd

echo "Creating conda env 'pyarrow-cuda'"
source $HOME/miniconda3/etc/profile.d/conda.sh
/usr/bin/time conda create --quiet --force --yes --name pyarrow-cuda \
  --channel conda-forge \
  --file arrow/ci/conda_env_unix.yml \
  --file arrow/ci/conda_env_cpp.yml \
  --file arrow/ci/conda_env_python.yml \
  python=3.7 \
  pandas \
  >> $EDGYR_LOGS/pyarrow.log 2>&1
conda activate pyarrow-cuda
export ARROW_HOME=$CONDA_PREFIX

echo "Configuring arrow-cpp"
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
      .. \
  >> $EDGYR_LOGS/pyarrow.log 2>&1

echo "Installing arrow-cpp"
/usr/bin/time ninja -j `nproc` \
  >> $EDGYR_LOGS/pyarrow.log 2>&1
ninja install \
  >> $EDGYR_LOGS/pyarrow.log 2>&1
popd

echo "Installing pyarrow"
pushd arrow/python
export PYARROW_WITH_CUDA=1
export PYARROW_WITH_PARQUET=1
/usr/bin/time python setup.py build_ext --inplace \
  >> $EDGYR_LOGS/pyarrow.log 2>&1
echo "Testing pyarrow"
/usr/bin/time pytest --quiet pyarrow \
  >> $EDGYR_LOGS/pyarrow.log 2>&1
popd

echo "Installing R package 'arrow'"
export PKG_CONFIG_PATH=$CONDA_PREFIX/lib/pkgconfig
export R_LD_LIBRARY_PATH=$R_LD_LIBRARY_PATH:$CONDA_PREFIX/lib
pushd arrow/r
/usr/bin/time Rscript -e "devtools::install('.', build_vignettes = TRUE)" \
  >> $EDGYR_LOGS/pyarrow.log 2>&1
popd
