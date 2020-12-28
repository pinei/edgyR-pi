#! /bin/bash -v

set -e

echo "cloning pocl"
rm -fr pocl*
git clone https://github.com/edgyR/pocl.git
