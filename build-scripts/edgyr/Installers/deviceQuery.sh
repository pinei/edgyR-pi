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

# We know $HOME/bin is in our PATH - TinyTeX put it there!
if [ ! -d $PROJECT_HOME/samples ]
then
  echo "Copying '/usr/local/samples' to '$PROJECT_HOME/'"
  cp -rp /usr/local/cuda/samples $PROJECT_HOME/
fi

if [ ! -x $EDGYR_HOME/bin/deviceQuery ]
then
  echo "Compiling 'deviceQuery"
  pushd $PROJECT_HOME/samples/1_Utilities/deviceQuery
  make >> $EDGYR_LOGS/deviceQuery.log 2>&1
  echo "Installing 'deviceQuery' in '$HOME/bin'"
  cp deviceQuery $HOME/bin/
  popd
fi

$HOME/bin/deviceQuery

echo "Finished"
