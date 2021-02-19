#! /bin/bash

set -e

mkdir --parents $HOME/src
cd $HOME/src
rm -fr samples
cp -rp /usr/local/cuda/samples .
pushd ./samples/1_Utilities/deviceQuery
make >> $EDGYR_LOGS/deviceQuery.log
cp deviceQuery $HOME/bin/
popd
$HOME/bin/deviceQuery
