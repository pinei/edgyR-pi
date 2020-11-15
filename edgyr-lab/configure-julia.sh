#! /bin/bash

set -e

echo "Enabling Julia kernel and 'CUDA.jl' in JupyterLab"
export JUPYTER=`which jupyter`
julia -e 'using Pkg; Pkg.add("IJulia"); Pkg.add("CUDA")'