#! /bin/bash

set -e

apt-get install -qqy --no-install-recommends \
  bison \
  flex \
  libeigen3-dev \
  libgmm++-dev \
  libmp3lame-dev \
  libpulse-dev \
  libsamplerate0-dev \
  libsndfile-dev \
  libstk0-dev \
  libwebsockets-dev \
  swig3.0

cd $SOURCE_DIR
export CSOUND_VERSION=6.15.0
curl -Ls https://github.com/csound/csound/archive/$CSOUND_VERSION.tar.gz | tar xzf -
cd csound-$CSOUND_VERSION/
mkdir cs6make 
cd cs6make/
cmake \
  -DBUILD_CUDA_OPCODES=ON \
  -DBUILD_STATIC_LIBRARY=ON \
  -DLAME_HEADER="/usr/include/lame/lame.h" \
  -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
  ..
make --jobs=`nproc`
make install
