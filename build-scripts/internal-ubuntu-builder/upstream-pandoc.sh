#! /bin/bash

set -e

apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  ca-certificates \
  curl \
  vim \
  wget

export BASE_URL=https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION
export FILE=pandoc-$PANDOC_VERSION-linux-arm64.tar.gz
echo $BASE_URL/$FILE
curl -Ls $BASE_URL/$FILE \
  | tar --directory=/usr/local --strip-components=1 --extract --gunzip --file=-
/usr/local/bin/pandoc --version
