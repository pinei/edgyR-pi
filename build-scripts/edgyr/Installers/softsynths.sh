#! /bin/bash

set -e

export CHUCK_VERSION=1.4.0.1
export CSOUND_VERSION=6.15.0
export FAUST_VERSION=2.30.5
export FLUIDSYNTH_VERSION=2.1.7
export LIBMUSICXML_VERSION=3.18
echo "Installing build dependencies"
sudo apt-get install -qqy --no-install-recommends \
  bison \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  gettext \
  ladspa-sdk \
  libasound2-dev \
  libdbus-1-dev \
  libeigen3-dev \
  libgmm++-dev \
  libjack-jackd2-dev \
  liblash-compat-dev \
  libmicrohttpd-dev \
  libmp3lame-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libpulse-dev \
  libreadline-dev \
  libsdl2-dev \
  libsndfile1-dev \
  libstk0-dev \
  libwildmidi-dev \
  llvm-10 \
  llvm-10-dev \
  llvm-10-runtime \
  llvm-10-tools \
  swig3.0 \
  >> $EDGYR_LOGS/softsynths.log 2>&1
mkdir --parents $HOME/src

cd $HOME/src
rm -fr fluidsynth*
echo "Downloading FluidSynth $FLUIDSYNTH_VERSION source"
curl -Ls \
  https://github.com/FluidSynth/fluidsynth/archive/v$FLUIDSYNTH_VERSION.tar.gz \
  | tar xzf -
cd fluidsynth-$FLUIDSYNTH_VERSION

echo "Compiling FluidSynth"
mkdir --parents build; cd build
cmake -DLIB_SUFFIX="" .. \
  >> $EDGYR_LOGS/softsynths.log 2>&1
/usr/bin/time make --jobs=`nproc` \
  >> $EDGYR_LOGS/softsynths.log 2>&1
echo "Installing FluidSynth"
sudo make install \
  >> $EDGYR_LOGS/softsynths.log 2>&1

cd $HOME/src
rm -fr libmusicxml*
echo "Downloading libmusicxml $LIBMUSICXML_VERSION source"
curl -Ls https://codeload.github.com/grame-cncm/libmusicxml/tar.gz/v3.18 \
  | tar xzf -
cd libmusicxml-$LIBMUSICXML_VERSION/build

echo "Compiling libmusicxml"
/usr/bin/time make --jobs=`nproc` \
  >> $EDGYR_LOGS/softsynths.log 2>&1
echo "Installing libmusicxml"
sudo make install \
  >> $EDGYR_LOGS/softsynths.log 2>&1

cd $HOME/src
rm -fr faust*
echo "Downloading faust $FAUST_VERSION source"
curl -Ls https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar xzf -
cd faust-$FAUST_VERSION

echo "Symlinking llvm-10-config"
sudo ln -s /usr/lib/llvm-10/bin/llvm-config /usr/bin/llvm-config
echo "Compiling faust"
/usr/bin/time make --jobs=`nproc` most \
  >> $EDGYR_LOGS/softsynths.log 2>&1
echo "Installing faust"
sudo make install \
  >> $EDGYR_LOGS/softsynths.log 2>&1
echo "Removing llvm-10 symlink"
sudo rm /usr/bin/llvm-config

cd $HOME/src
echo "Downloading CSound $CSOUND_VERSION source"
rm -fr csound*
wget -q -O - https://github.com/csound/csound/archive/$CSOUND_VERSION.tar.gz \
  | tar xzf -
cd csound-$CSOUND_VERSION/
mkdir cs6make
cd cs6make/
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH

echo "Compiling CSound"
cmake \
  -DBUILD_CUDA_OPCODES=ON \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  ..  >> $EDGYR_LOGS/softsynths.log 2>&1
/usr/bin/time make --jobs=`nproc` \
  >> $EDGYR_LOGS/softsynths.log 2>&1
echo "Installing CSound"
sudo make install >> $EDGYR_LOGS/softsynths.log 2>&1
sudo /sbin/ldconfig --verbose \
  >> $EDGYR_LOGS/softsynths.log 2>&1
cd ..
rm -fr cs6make

sudo rm -fr /usr/local/share/csound
sudo mkdir --parents /usr/local/share/csound
sudo mv /usr/local/share/samples /usr/local/share/csound/samples

cd $HOME/src
rm -fr chuck*
echo "Downloading ChucK $CHUCK_VERSION source"
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar xzf -
cd chuck-$CHUCK_VERSION/src

# the Jetson "native" sound infrastructure is ALSA
echo "Compiling ChucK for ALSA"
/usr/bin/time make linux-alsa \
  >> $EDGYR_LOGS/softsynths.log 2>&1
echo "Installing ChucK"
sudo make install \
  >> $EDGYR_LOGS/softsynths.log 2>&1

sudo rm -fr /usr/local/share/chuck
sudo mkdir --parents /usr/local/share/chuck
sudo mv ../examples /usr/local/share/chuck/examples

gzip -9 $EDGYR_LOGS/softsynths.log
