#! /bin/bash

set -e

export CHUCK_VERSION=1.4.0.1
export CSOUND_VERSION=6.15.0
export FAUST_VERSION=2.30.5
echo "Installing build dependencies"
sudo apt-get install -qqy --no-install-recommends \
  bison \
  flex \
  gettext \
  libmicrohttpd-dev \
  swig3.0 \
  >> $EDGYR_LOGS/synths.log 2>&1

mkdir --parents $HOME/src
cd $HOME/src
echo "Downloading CSound $CSOUND_VERSION source"
rm -fr csound*
wget -q -O - https://github.com/csound/csound/archive/$CSOUND_VERSION.tar.gz \
  | tar xzf -
cd csound-$CSOUND_VERSION/
mkdir cs6make
cd cs6make/
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH

cmake \
  -DBUILD_CUDA_OPCODES=ON \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  ..  >> $EDGYR_LOGS/synths.log 2>&1
echo "Compiling CSound"
/usr/bin/time make --jobs=`nproc` \
  >> $EDGYR_LOGS/synths.log 2>&1
echo "Installing CSound"
sudo make install >> $EDGYR_LOGS/synths.log 2>&1
sudo /sbin/ldconfig --verbose \
  >> $EDGYR_LOGS/synths.log 2>&1
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
echo "Compiling ChucK"
/usr/bin/time make linux-alsa \
  >> $EDGYR_LOGS/synths.log 2>&1
echo "Installing ChucK"
sudo make install \
  >> $EDGYR_LOGS/synths.log 2>&1

sudo rm -fr /usr/local/share/chuck
sudo mkdir --parents /usr/local/share/chuck
sudo mv ../examples /usr/local/share/chuck/examples

cd $HOME/src
rm -fr faust*
echo "Downloading faust $FAUST_VERSION source"
curl -Ls https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar xzf -
cd faust-$FAUST_VERSION

echo "Symlinking llvm-10-config"
sudo ln -s /usr/lib/llvm-10/bin/llvm-config /usr/bin/llvm-config
echo "Compiling faust"
/usr/bin/time make --jobs=`nproc` world \
  >> $EDGYR_LOGS/synths.log 2>&1
echo "Installing faust"
sudo make install \
  >> $EDGYR_LOGS/synths.log 2>&1
echo "Removing llvm-10 symlink"
sudo rm /usr/bin/llvm-config
