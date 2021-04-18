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
rm -f $LOGS/command-line-audio.log

echo "Installing command-line-audio tools"
apt-get install -y --no-install-recommends \
  alsa-tools \
  alsa-utils \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  libsox-dev \
  libsox-fmt-all \
  mp3splt \
  sox \
  timidity \
  >> $LOGS/command-line-audio.log 2>&1
apt-get clean
