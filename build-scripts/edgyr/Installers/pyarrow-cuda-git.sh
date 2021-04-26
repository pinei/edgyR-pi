#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

rm -f $EDGYR_LOGS/pyarrow-cuda-git.log

echo "Cloning arrow repository"
cd $PROJECT_HOME
rm -fr arrow
git clone https://github.com/apache/arrow.git
pushd arrow
git checkout apache-arrow-3.0.0
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

echo "Creating conda env 'pyarrow-cuda-git'"
source $HOME/miniconda3/etc/profile.d/conda.sh
/usr/bin/time conda create --quiet --force --yes --name pyarrow-cuda-git \
  --channel conda-forge \
  --file arrow/ci/conda_env_unix.yml \
  --file arrow/ci/conda_env_cpp.yml \
  --file arrow/ci/conda_env_python.yml \
  python=3.7 \
  pandas \
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1
conda activate pyarrow-cuda-git
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
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1

echo "Installing arrow-cpp"
/usr/bin/time ninja -j `nproc` \
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1
ninja install \
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1
popd

echo "Installing pyarrow"
pushd arrow/python
export PYARROW_WITH_CUDA=1
export PYARROW_WITH_PARQUET=1
/usr/bin/time python setup.py build_ext --inplace \
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1
echo "Testing pyarrow"
/usr/bin/time pytest --quiet pyarrow \
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1
popd

conda deactivate

echo "Installing R package 'devtools'"
$HOME/Installers/devtools.sh

echo "Installing R package 'arrow'"
pushd arrow/r
export INCLUDE_DIR=$CONDA_PREFIX/include
export LIB_DIR=$CONDA_PREFIX/lib
export R_LD_LIBRARY_PATH=$R_LD_LIBRARY_PATH:$CONDA_PREFIX/lib
/usr/bin/time Rscript -e \
  "devtools::install('.', build_vignettes = TRUE, quiet = TRUE)" \
  >> $EDGYR_LOGS/pyarrow-cuda-git.log 2>&1
popd

echo "Cleaning up"
conda clean --tarballs --index-cache --quiet --yes
conda list > $EDGYR_LOGS/pyarrow-cuda-git-conda-list.log

echo "Finished"
