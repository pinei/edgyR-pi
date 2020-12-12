#! /bin/bash

set -e

for package in \
  debhelper \
  init-system-helpers \
  nghttp2 \
  libuv1 \
  libnode-dev
do
  mkdir $package
  pushd $package
  apt-get build-dep -y $package > $LOGS/$package.log 2>&1
  apt-get source -y --compile $package >> $LOGS/$package.log 2>&1
  apt-get install -qqy --no-install-recommends ./*.deb >> $LOGS/$package.log 2>&1
  popd
done
