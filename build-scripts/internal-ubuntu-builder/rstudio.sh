#! /bin/bash -v

set -e

cd $SOURCE_DIR
rm -fr rstudio*
echo "Downloading RStudio source tarball"
curl -Ls \
  https://github.com/rstudio/rstudio/tarball/v$RSTUDIO_VERSION_MAJOR.$RSTUDIO_VERSION_MINOR.$RSTUDIO_VERSION_PATCH \
  | tar xzf -
mv rstudio-rstudio-* rstudio
cd rstudio

echo "Patching dependency install scripts"
cp -rp $SCRIPTS/dependencies/* dependencies/

echo "Installing dependencies - will take a while"
pushd dependencies/linux
/usr/bin/time ./install-dependencies-bionic > $LOGS/install-dependencies-bionic.log 2>&1
popd

echo "CMake"
rm -fr $SOURCE_DIR/rstudio/build/ \
  && mkdir --parents $SOURCE_DIR/rstudio/build/ \
  && pushd $SOURCE_DIR/rstudio/build/
cmake .. \
  -DRSTUDIO_TARGET=Server \
  -DCMAKE_BUILD_TYPE=Release

echo "Installing"
make --jobs=`nproc` install
popd

cd $SOURCE_DIR
rm -fr rstudio/build
