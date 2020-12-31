#! /bin/bash

set -e

cd $SOURCE_DIR
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar xzf -
cd chuck-$CHUCK_VERSION/src
make linux-pulse
make install

mkdir --parents /usr/local/share/chuck
mv ../examples /usr/local/share/chuck/examples
