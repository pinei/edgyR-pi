#! /bin/bash

echo "Installing build dependencies"
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  apt-file \
  build-essential \
  ca-certificates \
  curl \
  fakeroot \
  file \
  flac \
  gfortran \
  git \
  git-lfs \
  gnupg \
  libbz2-dev \
  libcairo2-dev  \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libicu-dev  \
  libjpeg-turbo8-dev  \
  libjpeg8-dev  \
  libpam0g-dev \
  liblzma-dev \
  libpango1.0-dev  \
  libpcre2-dev \
  libprotobuf-dev \
  libreadline-dev \
  libsndfile-dev \
  libsodium-dev \
  libsox-fmt-all \
  libssh2-1-dev \
  libssl-dev \
  libtiff5-dev \
  libxml2-dev \
  libzstd-dev \
  mlocate \
  openjdk-8-jdk-headless \
  pandoc \
  pandoc-citeproc \
  pandoc-citeproc-preamble \
  pkg-config \
  portaudio19-dev \
  protobuf-compiler \
  python-dev \
  python-virtualenv \
  python3-dev \
  python3-venv \
  python3-virtualenv \
  software-properties-common \
  sox \
  sudo \
  texinfo \
  time \
  tk-dev \
  tree \
  unzip \
  uuid-dev \
  vim-nox \
  virtualenv \
  virtualenvwrapper \
  wget \
  zip \
  zlib1g-dev

echo ""
echo "Installing spatial dependencies"
# https://wiki.postgresql.org/wiki/Apt
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  libgdal-dev \
  libudunits2-dev
update-alternatives --set editor /usr/bin/vim.nox
apt-get clean

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
cd build-dir
../$R_LATEST/configure --with-blas --enable-R-shlib

echo "Compiling"
make --jobs=`nproc`

echo "Making standalone math library"
pushd src/nmath/standalone
make --jobs=`nproc`
make install
popd

echo "Installing"
make install
cp $SCRIPTS/R.conf /etc/ld.so.conf.d/
/sbin/ldconfig --verbose
cd ..

echo "Reconfiguring R Java interface"
R CMD javareconf

cd $SOURCE_DIR
zip -9rmy $R_LATEST.zip $R_LATEST
zip -9rmy build-dir.zip build-dir