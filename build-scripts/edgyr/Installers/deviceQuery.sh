#! /bin/bash

cp -rp /usr/local/cuda/samples/1_Utilities/deviceQuery $SOURCE_DIR
cd $SOURCE_DIR/deviceQuery
make
cp deviceQuery /usr/local/bin/
deviceQuery
