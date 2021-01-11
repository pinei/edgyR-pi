#! /bin/bash

set -e

echo "Cloning POCL"
mkdir --parents $HOME/src; cd $HOME/src
rm -fr pocl*
git clone https://github.com/edgyR/pocl.git

pushd pocl
git checkout nano-fixes
rm -fr build; mkdir --parents build; cd build

# LLVM 10 doesn't recognize a Xavier so we use "generic"
echo "CMake"
cmake \
  -G Ninja \
  -DLLC_HOST_CPU=generic \
  -DENABLE_CUDA=ON \
  -DINSTALL_OPENCL_HEADERS=1 \
.. >> $EDGYR_LOGS/pocl.log 2>&1

echo "Compiling POCL"
/usr/bin/time ninja >> $EDGYR_LOGS/pocl.log 2>&1
echo "Installing POCL"
sudo ninja install >> $EDGYR_LOGS/pocl.log 2>&1

sudo cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $EDGYR_LOGS/clinfo.log 2>&1

echo "Running CUDA tests"
/usr/bin/time ../tools/scripts/run_cuda_tests >> $EDGYR_LOGS/pocl.log 2>&1 || true
echo "CUDA tests finished"
popd

sudo cp $HOME/Installers/etc/pocl.conf /etc/ld.so.conf.d/
sudo /sbin/ldconfig --verbose >> $EDGYR_LOGS/pocl.log 2>&1

echo "Installing / testing R 'OpenCL' package"
Rscript -e "source('~/Installers/R/OpenCL.R')" >> $EDGYR_LOGS/pocl.log 2>&1
