#! /bin/bash

# Copyright (C) 2021 M. Edward (Ed) Borasky <mailto:znmeb@algocompsynth.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e
rm -f $EDGYR_LOGS/csound.log
cd $PROJECT_HOME

echo "Checking for faust"
if [ ! -d /usr/local/include/faust ]
then
  echo "Faust missing - will install"
  echo "This takes a while"
  echo ""
  $HOME/Softsynths/faust.sh
else
  echo "Faust present - proceeding"
  echo ""
fi

echo "Installing dependencies"
sudo apt-get install -y --no-install-recommends \
  bison \
  dssi-dev \
  flex \
  gettext \
  hdf5-tools \
  libeigen3-dev \
  libgettextpo-dev \
  libgmm++-dev \
  libhdf5-dev \
  libhdf5-serial-dev \
  liblo-dev \
  liblua5.2-dev \
  libmp3lame-dev \
  libncurses5-dev \
  libpng-dev\
  libsamplerate0-dev \
  libstk0-dev \
  libwebsockets-dev \
  python-dev \
  python3-dev \
  swig3.0 \
  >> $EDGYR_LOGS/csound.log 2>&1
sudo apt-get clean

echo "Downloading csound source"
export CSOUND_VERSION="6.15.0"
rm -fr csound*
curl -Ls \
  https://github.com/csound/csound/archive/refs/tags/$CSOUND_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Configuring CSound"
rm -fr cs6make
mkdir cs6make
pushd cs6make

  export CPATH=/usr/include/lame:/usr/include/pulse:$CPATH
  cmake \
    -Wno-dev \
    -DBUILD_CUDA_OPCODES=ON \
    -DBUILD_STATIC_LIBRARY=ON \
    -DLAME_HEADER="/usr/include/lame/lame.h" \
    -DPULSEAUDIO_HEADER="/usr/include/pulse/simple.h" \
    -DLUA_H_PATH="/usr/include/lua5.2/" \
    -DLUA_LIBRARY="/usr/lib/aarch64-linux-gnu/liblua5.2.so" \
    -DBUILD_JAVA_INTERFACE=OFF \
    -DBUILD_P5GLOVE_OPCODES=OFF \
    -DBUILD_VIRTUAL_KEYBOARD=OFF \
    -DBUILD_WIIMOTE_OPCODES=OFF \
    -DUSE_FLTK=OFF \
    ../csound-$CSOUND_VERSION \
    >> $EDGYR_LOGS/csound.log 2>&1

  echo "Compiling CSound"
  make --jobs=`nproc` \
    >> $EDGYR_LOGS/csound.log 2>&1
  echo "Installing CSound"
  sudo make install \
    >> $EDGYR_LOGS/csound.log 2>&1
  sudo ldconfig
  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/cs6make $PROJECT_HOME/csound*
