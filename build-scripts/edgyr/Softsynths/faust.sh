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
rm -f $EDGYR_LOGS/faust.log
cd $PROJECT_HOME

echo "Installing Faust Linux dependencies"
sudo apt-get install -y --no-install-recommends \
  libmicrohttpd-dev \
  libssl-dev \
  libtinfo-dev \
  >> $EDGYR_LOGS/faust.log 2>&1
sudo apt-get clean

echo "Downloading faust source"
export FAUST_VERSION="2.30.5"
rm -fr faust*
curl -Ls \
  https://github.com/grame-cncm/faust/releases/download/$FAUST_VERSION/faust-$FAUST_VERSION.tar.gz \
  | tar --extract --gunzip --file=-

echo "Compiling faust"
cd faust-$FAUST_VERSION/build
export CMAKEOPT="-Wno-dev"
cat targets/all.cmake \
  >> $EDGYR_LOGS/faust.log 2>&1
cat backends/light.cmake \
  >> $EDGYR_LOGS/faust.log 2>&1
make TARGETS=all.cmake BACKENDS=light.cmake \
  >> $EDGYR_LOGS/faust.log 2>&1
echo "Installing faust"
sudo make install \
  >> $EDGYR_LOGS/faust.log 2>&1
sudo ldconfig

echo "Cleanup"
rm -fr $PROJECT_HOME/faust*
