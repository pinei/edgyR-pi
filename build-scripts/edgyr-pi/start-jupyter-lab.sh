#! /bin/bash

set -e

cd $HOME
echo ""
echo "Activating r-reticulate conda environment"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate
echo "Generating Jupyter configuration file"
jupyter notebook --generate-config
echo "Enter the same strong password twice"
jupyter server password
echo "If running remotely, browse to port 8888 on this Jetson host instead of 'localhost'"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
