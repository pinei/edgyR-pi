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
cd build-dir
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
cp $SCRIPTS/R.conf /etc/ld.so.conf.d/
/sbin/ldconfig --verbose
cd ..

echo "Reconfiguring R Java interface"
R CMD javareconf

cd $SOURCE_DIR
zip -9rmyq $R_LATEST.zip $R_LATEST
zip -9rmyq build-dir.zip build-dir
