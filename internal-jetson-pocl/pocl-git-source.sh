#! /bin/bash -v

set -e

echo "cloning pocl"
cd $SOURCE_DIR
rm -fr pocl*
git clone https://github.com/edgyR/pocl.git
cd pocl
