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
cd $PROJECT_HOME

echo "Installing FluidSynth Linux dependencies"
sudo apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  fluid-soundfont-gm \
  fluid-soundfont-gs  \
  ladspa-sdk \
  libasound2-dev \
  libdbus-1-dev \
  libglib2.0-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libreadline-dev \
  libsdl2-dev \
  libsndfile1-dev \
  libsystemd-dev \
  portaudio19-dev \
  time
sudo apt-get clean

echo "Downloading libinstpatch"
rm -fr libinstpatch*
curl -Ls \
  https://github.com/swami/libinstpatch/archive/refs/tags/v$LIBINSTPATCH_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd libinstpatch-$LIBINSTPATCH_VERSION

  echo "Configuring libinstpatch"
  mkdir --parents build; cd build
  cmake \
    -Wno-dev \
    -DLIB_SUFFIX="" \
    ..

  echo "Compiling libinstpatch"
  /usr/bin/time make --jobs=`nproc`

  echo "Installing libinstpatch"
  sudo make install
  sudo ldconfig
  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/libinstpatch*

echo "Downloading fluidsynth"
rm -fr fluidsynth*
curl -Ls \
  https://github.com/FluidSynth/fluidsynth/archive/refs/tags/v$FLUIDSYNTH_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd fluidsynth-$FLUIDSYNTH_VERSION

  echo "Configuring FluidSynth"
  mkdir --parents build; cd build
  cmake \
    -Wno-dev \
    -DLIB_SUFFIX="" \
    -Denable-portaudio=ON \
    ..

  echo "Compiling FluidSynth"
  /usr/bin/time make --jobs=`nproc`
  echo "Installing FluidSynth"
  sudo make install
  sudo ldconfig
  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/fluidsynth*
