#! /bin/bash -v

set -e

echo "cloning pocl"
mkdir --parents $HOME/src; cd $HOME/src
rm -fr pocl*
git clone https://github.com/edgyR/pocl.git

pushd pocl
git checkout nano-fixes
rm -fr build; mkdir --parents build; cd build

# LLVM 10 doesn't recognize a Xavier so we use "generic"
cmake \
  -G Ninja \
  -DLLC_HOST_CPU=generic \
  -DENABLE_CUDA=ON \
  -DINSTALL_OPENCL_HEADERS=1 \
..

ninja
sudo ninja install

sudo cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1

echo "running CUDA tests"
../tools/scripts/run_cuda_tests
echo "CUDA tests finished"
popd

sudo cp $EDGYR_SCRIPTS/pocl.conf /etc/ld.so.conf.d/
sudo /sbin/ldconfig --verbose

Rscript -e "source('~/Installers/R/OpenCL.R')"
