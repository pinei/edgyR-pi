#! /bin/bash

echo "Installing Linux dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  clinfo \
  cmake \
  curl \
  default-jdk-headless \
  file \
  flac \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libarrayfire-opencl-dev \
  libbz2-dev \
  libcairo2-dev \
  libclc-dev \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libicu-dev \
  libigc-dev \
  libigdfcl-dev \
  libjpeg-dev \
  libjpeg-turbo8-dev \
  libjpeg8-dev \
  liblld-10-dev \
  liblldb-10-dev \
  liblzma-dev \
  libncurses-dev \
  libnuma-dev \
  libopencl-clang-dev \
  libopentk-cil-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libpng-dev \
  libreadline-dev \
  libsndfile-dev \
  libsodium-dev \
  libsox-dev \
  libsox-fmt-all \
  libssh2-1-dev \
  libssl-dev \
  libtiff5-dev \
  libudunits2-dev \
  libviennacl-dev \
  libxml2-dev \
  lsof \
  mlocate \
  ninja-build \
  nvidia-opencl-dev \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  openssh-client \
  pandoc \
  pandoc-citeproc \
  pandoc-citeproc-preamble \
  pkg-config \
  portaudio19-dev \
  python2 \
  python2-dev \
  python3 \
  python3-dev \
  python3-venv \
  python3-virtualenv \
  python3-virtualenvwrapper \
  software-properties-common \
  sox \
  sudo \
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  vim-nox \
  virtualenv \
  virtualenvwrapper \
  wget \
  zip \
  zlib1g-dev
update-alternatives --set editor /usr/bin/vim.nox

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
cp $SCRIPTS/cran.list /etc/apt/sources.list.d/
apt-get update
apt-get install -qqy --no-install-recommends r-base-dev

mkdir --parents $SOURCE_DIR/Downloads/Installers
pushd $SOURCE_DIR/Downloads/Installers
rm -f ./rstudio-server*.deb
wget -q $RSTUDIO_PACKAGE
apt-get install -qqy --no-install-recommends ./rstudio-server*.deb
popd

echo "installing Intel GPU OpenCL"
# https://dgpu-docs.intel.com/installation-guides/ubuntu/ubuntu-focal.html
wget -qO - https://repositories.intel.com/graphics/intel-graphics.key \
  | apt-key add -
apt-add-repository \
  'deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main'
apt-get update
apt-get install -qqy --no-install-recommends \
  intel-opencl-icd \
  intel-level-zero-gpu level-zero \
  intel-media-va-driver-non-free libmfx1
  libigc-dev \
  libigdfcl-dev \
  libigfxcmrt-dev \
  intel-igc-opencl-devel \
  level-zero-devel level-zero-dev
clinfo
