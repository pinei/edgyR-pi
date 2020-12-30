#! /bin/bash

set -e

cd $SOURCE_DIR
curl -Ls https://chuck.cs.princeton.edu/release/files/chuck-$CHUCK_VERSION.tgz \
  | tar xzf -
cd chuck-$CHUCK_VERSION/src
make linux-alsa
make install
