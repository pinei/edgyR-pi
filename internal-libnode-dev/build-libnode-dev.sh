#! /bin/bash

set -e

add-apt-repository ppa:cran/v8
apt-get update

if [ `uname -m` = "x86_64" ]
then
  apt-get install -qqy --no-install-recommends libnode-dev
else

  # enable source repositories
  cp $SCRIPTS/cran-ubuntu-v8-bionic.list /etc/apt/sources.list.d/cran-ubuntu-v8-bionic.list
  cp $SCRIPTS/sources.list /etc/apt/sources.list
  apt-get update

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
    cp ./*.deb $PACKAGES/
    popd
  done

fi
