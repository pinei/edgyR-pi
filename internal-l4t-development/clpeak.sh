#! /bin/bash

set -e

rm -fr clpeak
git clone --recurse-submodules https://github.com/krrishnarraj/clpeak.git
cd clpeak
#git checkout $CLPEAK_VERSION
mkdir --parents build; cd build
cmake ..
cmake --build .
./clpeak -p 0 -d 0 > $LOGS/clpeak_0_0.log 2>&1
./clpeak -p 0 -d 1 > $LOGS/clpeak_0_1.log 2>&1
