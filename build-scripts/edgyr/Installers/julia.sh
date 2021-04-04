#! /bin/bash

set -e

export JULIA_VERSION_MAJOR=1
export JULIA_VERSION_MINOR=6
export JULIA_VERSION_PATCH=0
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

