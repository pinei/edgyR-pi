#! /bin/bash

set -e

echo "Cloning 'cusignal'"
cd $SOURCE_DIR
export CUSIGNAL_VERSION=v0.18.0
export CUSIGNAL_HOME=$(pwd)/cusignal
rm -fr $CUSIGNAL_HOME
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
echo "Checking out version '$CUSIGNAL_VERSION'"
git checkout $CUSIGNAL_VERSION

sed --in-place=.bak --expression='s;python setup.py;python3 setup.py;' ./build.sh
/usr/bin/time ./build.sh --allgpuarch \
  >> $LOGS/cusignal.log 2>&1
echo "Copying '$CUSIGNAL_HOME/notebooks' to '/usr/local/share/cusignal-notebooks'"
cp -rp $CUSIGNAL_HOME/notebooks /usr/local/share/cusignal-notebooks
