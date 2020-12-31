#! /bin/bash

set -e

cd $SOURCE_DIR
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
  ..
make --jobs=`nproc`
make install

mkdir --parents /usr/local/share/csound
mv /usr/local/share/samples /usr/local/share/csound/samples
