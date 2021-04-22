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

# https://github.com/supercollider/supercollider/wiki/Installing-supercollider-from-source-on-Ubuntu

set -e
rm -f $EDGYR_LOGS/supercollider.log
cd $PROJECT_HOME

echo "Installing Linux dependencies"
sudo apt-get install -y --no-install-recommends \
  emacs-nox \
  libavahi-client-dev \
  libfftw3-dev \
  libfftw3-mpi-dev \
  libncurses5-dev \
  >> $EDGYR_LOGS/supercollider.log 2>&1
sudo apt-get clean

echo "Downloading supercollider source"
export SUPERCOLLIDER_VERSION="3.11.2"
rm -fr SuperCollider*
export SUPERCOLLIDER_REPO="https://github.com/supercollider/supercollider/releases/download/Version-$SUPERCOLLIDER_VERSION"
export SUPERCOLLIDER_FILE="SuperCollider-$SUPERCOLLIDER_VERSION-Source.tar.bz2"
curl -Ls $SUPERCOLLIDER_REPO/$SUPERCOLLIDER_FILE \
  | tar --extract --bzip2 --file=- \
  >> $EDGYR_LOGS/supercollider.log 2>&1
pushd SuperCollider*
  export SC_PATH=$PWD

  echo "Configuring supercollider"
  rm -fr build && mkdir build && cd build
  cmake \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DSC_ABLETON_LINK=OFF \
    -DENABLE_TESTSUITE=OFF \
    -DLIBSCSYNTH=OFF \
    -DINSTALL_HELP=OFF \
    -DNO_X11=ON \
    -DSCLANG_SERVER=ON \
    -DSC_IDE=OFF \
    -DSC_QT=OFF \
    -DSC_ED=OFF \
    .. \
    >> $EDGYR_LOGS/supercollider.log 2>&1

  echo "Compiling supercollider"
  make --jobs=`nproc` \
    >> $EDGYR_LOGS/supercollider.log 2>&1

  echo "Installing supercollider"
  sudo make install \
    >> $EDGYR_LOGS/supercollider.log 2>&1
  sudo ldconfig
  popd

echo "Downloading sc3-plugins source"
export SC3_PLUGINS_VERSION="3.11.1"
rm -fr sc3-plugins*
export SC3_PLUGINS_REPO="https://github.com/supercollider/sc3-plugins/releases/download/Version-$SC3_PLUGINS_VERSION"
export SC3_PLUGINS_FILE="sc3-plugins-$SC3_PLUGINS_VERSION-Source.tar.bz2"
curl -Ls $SC3_PLUGINS_REPO/$SC3_PLUGINS_FILE \
  | tar --extract --bzip2 --file=- \
  >> $EDGYR_LOGS/supercollider.log 2>&1
pushd sc3-plugins*

  echo "Building sc3-plugins"
  mkdir build && cd build
  cmake \
    -Wno-dev \
    -DCMAKE_BUILD_TYPE=Release \
    -DNATIVE=ON \
    -DQUARKS=ON \
    .. \
    >> $EDGYR_LOGS/supercollider.log 2>&1
  make --jobs=`nproc` \
    >> $EDGYR_LOGS/supercollider.log 2>&1
  echo "Installing sc3-plugins"
  sudo make install \
    >> $EDGYR_LOGS/supercollider.log 2>&1
  sudo ldconfig
  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/SuperCollider*
rm -fr $PROJECT_HOME/sc3-plugins*
