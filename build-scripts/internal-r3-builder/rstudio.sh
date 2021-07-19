#! /bin/bash

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
echo "Patching RStudio's hard-coded PANDOC_VERSION"
sed \
  --in-place=.bak \
  --expression="s/PANDOC_VERSION .* CACHE/PANDOC_VERSION \"$PANDOC_VERSION\" CACHE/" \
  $SOURCE_DIR/rstudio/src/cpp/session/CMakeLists.txt
diff \
  $SOURCE_DIR/rstudio/src/cpp/session/CMakeLists.txt \
  $SOURCE_DIR/rstudio/src/cpp/session/CMakeLists.txt.bak || true

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
export RAM_KILOBYTES=`ram_kilobytes.sh`
if [ "$RAM_KILOBYTES" -lt "6000000" ]
then
  export JOBS=2
else
  export JOBS=`nproc`
fi

make --jobs=$JOBS install
popd

cd $SOURCE_DIR
rm -fr rstudio
