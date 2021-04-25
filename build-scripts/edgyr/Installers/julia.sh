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

export JULIA_VERSION_MAJOR=1
export JULIA_VERSION_MINOR=6
export JULIA_VERSION_PATCH=1
echo ""
echo "Installing 'julia' in '/usr/local'"
export WHERE="https://julialang-s3.julialang.org/bin/linux/aarch64"
export RELEASE_DIR="$JULIA_VERSION_MAJOR.$JULIA_VERSION_MINOR"
export JULIA_TARBALL="julia-$RELEASE_DIR.$JULIA_VERSION_PATCH-linux-aarch64.tar.gz"
curl -Ls "$WHERE/$RELEASE_DIR/$JULIA_TARBALL" \
  | sudo tar --strip-components=1 --directory=/usr/local -xzf -
echo "Installing 'CUDA.jl' for 'edgyr' user"
/usr/bin/time julia -e 'using Pkg; Pkg.add("CUDA")' \
  >> $EDGYR_LOGS/julia.log 2>&1
echo "Enabling Julia kernel in JupyterLab"
export JUPYTER=`which jupyter`
echo "JUPYTER=$JUPYTER"
/usr/bin/time julia -e 'using Pkg; Pkg.add("IJulia")' \
  >> $EDGYR_LOGS/julia.log 2>&1


echo "Finished"
