#! /bin/bash

set -e

export CSOUND_VERSION=6.15.0
export CHUCK_VERSION=1.4.0.1
echo "Installing build dependencies"
sudo apt-get install -qqy --no-install-recommends \
  bison \
  flex \
  gettext \
  swig3.0 \
> $HOME/logs/audio.log 2>&1

mkdir --parents $HOME/src
cd $HOME/src
echo "Downloading CSound $CSOUND_VERSION source"
rm -fr csound*
wget -q -O - https://github.com/csound/csound/archive/$CSOUND_VERSION.tar.gz | tar xzf -
cd csound-$CSOUND_VERSION/
mkdir cs6make 
cd cs6make/
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH

cmake \
  -DBUILD_CUDA_OPCODES=ON \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  ..  >> $HOME/logs/audio.log 2>&1
echo "Compiling CSound"
/usr/bin/time make --jobs=`nproc` >> $HOME/logs/audio.log 2>&1
echo "Installing CSound"
sudo make install >> $HOME/logs/audio.log 2>&1
sudo /sbin/ldconfig --verbose >> $HOME/logs/audio.log 2>&1
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
/usr/bin/time make linux-alsa >> $HOME/logs/audio.log 2>&1
echo "Installing ChucK"
sudo make install >> $HOME/logs/audio.log 2>&1

sudo rm -fr /usr/local/share/chuck
sudo mkdir --parents /usr/local/share/chuck
sudo mv ../examples /usr/local/share/chuck/examples

echo "Installing R audio packages"
Rscript -e "source('~/Installers/R/audio.R')" >> $HOME/logs/audio.log 2>&1
