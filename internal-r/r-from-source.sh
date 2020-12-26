#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  file \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libbz2-dev \
  libcairo2-dev \
  libcurl4-openssl-dev \
  libicu-dev \
  libjpeg-turbo8-dev \
  libjpeg8-dev \
  liblzma-dev \
  libncurses-dev \
  libpango1.0-dev \
  libpcre2-dev \
  libreadline-dev \
  libtiff5-dev \
  lsof \
  mlocate \
  openjdk-8-jdk \
  pkg-config \
  software-properties-common \
  sudo \
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  vim-nox \
  wget \
  zip \
  zlib1g-dev
apt-get clean
update-alternatives --set editor /usr/bin/vim.nox

echo "Creating / entering source directory"
mkdir --parents $SOURCE_DIR && cd $SOURCE_DIR

echo "Removing old R source directories"
rm -fr R-*

export WEBSITE="https://cloud.r-project.org/src/base"
export RELEASE_DIR="R-$R_VERSION_MAJOR"
export R_TARBALL="$R_LATEST.tar.gz"

echo "Downloading $WEBSITE/$RELEASE_DIR/$R_TARBALL"
curl -Ls "$WEBSITE/$RELEASE_DIR/$R_TARBALL" | tar xzf -
echo "Using $R_LATEST"

echo "Configuring"
mkdir --parents build-dir

pushd build-dir
  ../$R_LATEST/configure --enable-R-shlib

  echo "Compiling"
  make --jobs=`nproc`

  echo "Making standalone math library"
  pushd src/nmath/standalone
    make --jobs=`nproc`
    make install
  popd

  echo "Installing"
  make install
popd

cd $SOURCE_DIR
zip -rmyq $R_LATEST.zip $R_LATEST
rm -fr build_dir
