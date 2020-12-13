#! /bin/bash

set -e

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  build-essential \
  ca-certificates \
  clang-10 \
  clang-format-10 \
  clang-tidy-10 \
  clang-tools-10 \
  clinfo \
  cmake \
  gdb \
  git \
  libclang-10-dev \
  libclang-cpp10-dev \
  libfuzzer-10-dev \
  libhwloc-dev \
  liblld-10-dev \
  liblldb-10-dev \
  liblttng-ust-dev \
  libomp-10-dev \
  lld-10 \
  lldb-10 \
  llvm-10-dev \
  llvm-10 \
  llvm-10-runtime \
  llvm-10-tools \
  ninja-build \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  pkg-config \
  r-base-dev \
  vim-nox

echo ""
echo "downloading pocl source"
rm -fr pocl-*
wget -q -O - https://github.com/pocl/pocl/archive/v$POCL_VERSION.tar.gz \
  | tar xzf -

pushd "pocl-$POCL_VERSION"
mkdir --parents build; cd build
cmake \
  -G Ninja \
  -DLLC_HOST_CPU=generic \
  -DENABLE_CUDA=ON \
  -DINSTALL_OPENCL_HEADERS=1 \
..

ninja
ninja install

cp $SCRIPTS/pocl.conf /etc/ld.so.conf.d/
/sbin/ldconfig --verbose
cp -rp /usr/local/etc/OpenCL /etc/
clinfo > $LOGS/clinfo.log 2>&1
popd
