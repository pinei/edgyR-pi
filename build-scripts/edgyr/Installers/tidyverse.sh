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
rm -f $EDGYR_LOGS/tidyverse.log 2>&1


echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > $EDGYR_LOGS/tidyverse.log 2>&1
sudo apt-get upgrade -y >> $EDGYR_LOGS/tidyverse.log 2>&1
sudo apt-get install -qqy --no-install-recommends \
  libpq-dev \
  unixodbc-dev \
  >> $EDGYR_LOGS/tidyverse.log 2>&1
echo "Installing R packages"
echo "This takes about 21 minutes on a 4 GB Nano"
echo "and 11 minutes on an AGX Xavier"
/usr/bin/time Rscript -e "source('~/Installers/R/tidyverse.R')" \
  >> $EDGYR_LOGS/tidyverse.log 2>&1

echo "Finished"
