#! /bin/bash

set -e

echo "Activating conda env 'r-reticulate'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate
echo "Installing arrow dependencies"
conda install --quiet --yes \
  boost-cpp>=1.68.0 \
  brotli \
  bzip2 \
  cython \
  hypothesis \
  libutf8proc \
  pytest-lazy-fixture \
  rapidjson \
  re2 \
  snappy \
  thrift-cpp>=0.11.0
    #--file arrow/ci/conda_env_unix.yml \
    #--file arrow/ci/conda_env_cpp.yml \
    #--file arrow/ci/conda_env_python.yml \
    #--file arrow/ci/conda_env_gandiva.yml > $EDGYR_LOGS/pyarrow.log 2>&1
export ARROW_HOME=$CONDA_PREFIX

echo "Cloning 'arrow' repository"
mkdir --parents $CONDA_PREFIX/src
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
diff $HOME/Installers/etc/CMakeLists.txt-cuda-patch arrow/cpp/src/arrow/gpu/CMakeLists.txt || true
cp $HOME/Installers/etc/CMakeLists.txt-cuda-patch arrow/cpp/src/arrow/gpu/CMakeLists.txt
diff $HOME/Installers/etc/CMakeLists.txt-cuda-patch arrow/cpp/src/arrow/gpu/CMakeLists.txt

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
      .. #>> $EDGYR_LOGS/pyarrow.log 2>&1

echo "Installing arrow-cpp"
ninja -j `nproc` >> $EDGYR_LOGS/pyarrow.log 2>&1
ninja install >> $EDGYR_LOGS/pyarrow.log 2>&1
popd

echo "Installing pyarrow"
pushd arrow/python
export PYARROW_WITH_CUDA=1
export PYARROW_WITH_PARQUET=1
python setup.py build_ext --inplace #>> $EDGYR_LOGS/pyarrow.log 2>&1
echo "Testing pyarrow"
pytest pyarrow >> $EDGYR_LOGS/pyarrow.log 2>&1
popd
