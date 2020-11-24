#! /bin/bash

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
  ../$R_LATEST/configure --enable-R-shlib --prefix=$BINARIES

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
