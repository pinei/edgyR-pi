#! /bin/bash -v

set -e

apt-get install -qqy --no-install-recommends \
  ant \
  cmake
apt-get clean
update-alternatives --set java /usr/lib/jvm/java-8-openjdk-arm64/jre/bin/java
ls -lAtr /etc/alternatives | grep java

cd $SOURCE_DIR
rm -fr rstudio*
echo "Downloading RStudio source tarball"
curl -Ls \
  https://github.com/rstudio/rstudio/tarball/v$RSTUDIO_VERSION_MAJOR.$RSTUDIO_VERSION_MINOR.$RSTUDIO_VERSION_PATCH \
  | tar xzf -
mv rstudio-rstudio-* rstudio
cd rstudio

pushd dependencies/common
  echo "Installing RStudio boost from source - may take a while"
  alias make=make --jobs=`nproc`
  /usr/bin/time ./install-boost

  echo "Acuiring Pandoc version"
  export PANDOC_VERSION=`pandoc --version|head -n 1|sed 's/^pandoc //'`
  echo "PANDOC_VERSION=$PANDOC_VERSION"

  echo "Installing dictionaries"
  ./install-dictionaries > /dev/null 2>&1
  echo "Installing MathJax" 
  ./install-mathjax > /dev/null 2>&1
  echo "Copying Pandoc binaries"
  mkdir -p pandoc/$PANDOC_VERSION/
  cp /usr/bin/pandoc* pandoc/$PANDOC_VERSION/
popd

cd $SOURCE_DIR/rstudio

echo "Testing R version"
# R 4.0.0+ no longer uses the symbol 'R_Slave'. As a result, there will be an
# error compiling RStudio for R more recent than 3.6.3. So if we have a newer
# R we patch the source here.
export R_VERSION_MAJOR=`R --version | head -n 1 | sed 's/^R version //' | sed 's/\..*$//'`
echo "R_VERSION_MAJOR = $R_VERSION_MAJOR"
if [ $R_VERSION_MAJOR -gt "3" ]
then
  echo "Patching RStudio source"
  sed --in-place=.bak --expression='s/R_Slave/R_NoEcho/g' $SOURCE_DIR/rstudio/src/cpp/r/session/REmbeddedPosix.cpp
fi

echo "CMake"
rm -fr $SOURCE_DIR/rstudio/build/ \
  && mkdir --parents $SOURCE_DIR/rstudio/build/ \
  && pushd $SOURCE_DIR/rstudio/build/
cmake .. \
  -DRSTUDIO_TARGET=Server \
  -DCMAKE_BUILD_TYPE=Release \
  -DCPACK_GENERATOR=TGZ \
  -DCPACK_SOURCE_GENERATOR=TGZ

# The C/C++ builds and the Java "gwt_build" appear to be competing for cores
# and RAM. And the Java one doesn't seem to remember that it's been done.
# So we run the C/C++ ones first, then do a "make install" to clean up
# and stragglers and do the "gwt_build".

echo "Building the C/C++ components"
make --jobs=`nproc` rstudio-core-synctex \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-core-hunspell \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-shared-core \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-shared-core-tests \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-core \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-session-workers \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` crash-handler-proxy \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-monitor \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-server-core \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-core-tests \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-server-core-tests \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rserver-pam \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rpostback \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rstudio-r \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rserver \
  >> $LOGS/cpp-compile.log 2>&1
make --jobs=`nproc` rsession \
  >> $LOGS/cpp-compile.log 2>&1

# The Nano only has 4 GB of RAM. As a result, the Java builds swamp the available
# RAM and multi-job makes are problematic - they swap and the system appears
# unresponsive.
#
# So we only run two-job makes if we have less than 5 GB of RAM.
export RAM_KILOBYTES=`grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'`
if [ $RAM_KILOBYTES -ge "5000000" ]
then
  export JOBS=4
else
  export JOBS=2
fi
echo "Installing"
echo " -- starting Java builds"
echo " -- RAM_KILOBYTES = $RAM_KILOBYTES; 'make' will use $JOBS jobs."

make --jobs=$JOBS package

echo "Copying package tarball to $PACKAGES"
cp $PACKAGE_FILE $PACKAGES/
