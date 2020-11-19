#! /bin/bash

echo "Updating 'cabal' package list"
export PATH=/root/.cabal/bin/:$PATH
which cabal
cabal update

echo "Building 'pandoc' with 'cabal'"
cd pandoc
git checkout 2.11.1.1
/usr/bin/time cabal install \
  --disable-optimization \
  --flags="embed_data_files https" \
pandoc
