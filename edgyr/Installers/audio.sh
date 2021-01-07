#! /bin/bash

set -e

export CSOUND_VERSION=6.15.0
export CHUCK_VERSION=1.4.0.1
sudo apt-get install -qqy --no-install-recommends \
  bison \
  flex \
  gettext \
  swig3.0

mkdir --parents $HOME/src
cd $HOME/src
rm -fr csound*
wget -q -O - https://github.com/csound/csound/archive/$CSOUND_VERSION.tar.gz | tar xzf -
cd csound-$CSOUND_VERSION/
mkdir cs6make 
cd cs6make/
export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH

if [ `clinfo --list | grep Device | wc -l` -gt "0" ]
then
  export OPENCL_EXISTS="ON"
else
  export OPENCL_EXISTS="OFF"
fi

cmake \
  -DBUILD_CUDA_OPCODES=ON \
  -DBUILD_OPENCL_OPCODES=$OPENCL_EXISTS \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  ..
make --jobs=`nproc`
sudo make install
cd ..
rm -fr cs6make

sudo mkdir --parents /usr/local/share/csound
sudo mv /usr/local/share/samples /usr/local/share/csound/samples

cd $HOME/src
rm -fr chuck*
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar xzf -
cd chuck-$CHUCK_VERSION/src
make linux-pulse
sudo make install

sudo mkdir --parents /usr/local/share/chuck
sudo mv ../examples /usr/local/share/chuck/examples

Rscript -e "source('~/Installers/R/audio.R')"
