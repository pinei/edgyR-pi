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
rm -f $EDGYR_LOGS/chuck.log
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

echo "Installing ChucK Linux dependencies"
sudo apt-get install -y --no-install-recommends \
  bison \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libsndfile1-dev \
  >> $EDGYR_LOGS/chuck.log 2>&1
sudo apt clean

echo "Downloading ChucK source"
export CHUCK_VERSION="1.4.0.1"
rm -fr chuck*
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar --extract --gunzip --file=-
pushd chuck-$CHUCK_VERSION/src

  echo "Compiling ChucK for jack"
  make --jobs=`nproc` linux-jack \
    >> $EDGYR_LOGS/chuck.log 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $EDGYR_LOGS/chuck.log 2>&1
  sudo ldconfig

  echo "Relocating ChucK examples"
  sudo rm -fr /usr/local/share/chuck
  sudo mkdir --parents /usr/local/share/chuck
  sudo mv ../examples /usr/local/share/chuck/examples
  popd

echo "Installing Chugins"
rm -fr chugins*
git clone https://github.com/ccrma/chugins.git \
  >> $EDGYR_LOGS/chuck.log 2>&1
pushd chugins

  make linux \
    >> $EDGYR_LOGS/chuck.log 2>&1
  sudo make install \
    >> $EDGYR_LOGS/chuck.log 2>&1
  sudo ldconfig
  pushd Faust

    echo "Installing Fauck"
    make linux \
      >> $EDGYR_LOGS/chuck.log 2>&1
    sudo make install \
      >> $EDGYR_LOGS/chuck.log 2>&1
    sudo ldconfig
    popd

  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/chuck $SOURCE_DIR/chugins

echo "Finished"
