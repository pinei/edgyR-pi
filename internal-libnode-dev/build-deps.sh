#! /bin/bash

set -e

apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  build-essential \
  software-properties-common
add-apt-repository ppa:cran/v8
apt-get update

# enable source repositories
cp $SCRIPTS/cran-ubuntu-v8-bionic.list /etc/apt/sources.list.d/cran-ubuntu-v8-bionic.list
cp $SCRIPTS/sources.list /etc/apt/sources.list
apt-get update
