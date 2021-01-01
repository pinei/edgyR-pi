#! /bin/bash

set -e

cd $HOME
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate
echo ""
echo "Enter the same strong password twice"
jupyter notebook password
echo "If running remotely, browse to port 8888 on this host instead of 'localhost'"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0
