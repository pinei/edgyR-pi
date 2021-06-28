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
  libsndfile1-dev
sudo apt-get clean

echo "Downloading ChucK source"
rm -fr chuck*
curl -Ls https://github.com/ccrma/chuck/archive/refs/tags/chuck-$CHUCK_VERSION.tar.gz \
  | tar --extract --gunzip --file=-
pushd chuck-chuck-$CHUCK_VERSION/src

  echo "Compiling ChucK for jack"
  make --jobs=`nproc` linux-jack
  echo "Installing ChucK"
  sudo make install
  sudo ldconfig

  echo "Relocating ChucK examples"
  sudo rm -fr /usr/local/share/chuck
  sudo mkdir --parents /usr/local/share/chuck
  sudo mv ../examples /usr/local/share/chuck/examples
  popd

echo "Installing Chugins"
rm -fr chugins*
git clone https://github.com/ccrma/chugins.git
pushd chugins

  make linux
  sudo make install
  sudo ldconfig
  pushd Faust

    echo "Installing Fauck"
    make linux
    sudo make install
    sudo ldconfig
    popd

  popd

echo "Cleanup"
rm -fr $PROJECT_HOME/chuck $SOURCE_DIR/chugins

echo "Finished"
