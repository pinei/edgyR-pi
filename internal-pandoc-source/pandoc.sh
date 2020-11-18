#! /bin/bash

echo "Updating 'cabal' package list"
cabal update

echo "Building 'pandoc' with 'cabal'"
/usr/bin/time cabal install pandoc -fembed_data_files
