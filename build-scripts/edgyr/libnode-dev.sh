#! /bin/bash

set -e

echo "Installng 'libnode-dev' and dependencies packages"
pushd /usr/local/src/packages
apt-get install -qqy --no-install-recommends \
  ./libnghttp2-14_*.deb \
  ./libuv1_*.deb \
  ./libuv1-dev_*.deb \
  ./libnode64_*.deb \
  ./libnode-dev_*.deb
popd
