#! /bin/bash

set -e

apt-get install -qqy --no-install-recommends \
  ca-certificates \
  curl \
  wget
apt-get clean

if [ `uname -m` = "x86_64" ]
then
  export FILE=pandoc-$PANDOC_VERSION-linux-amd64.tar.gz
else
  export FILE=pandoc-$PANDOC_VERSION-linux-arm64.tar.gz
fi

export BASE_URL=https://github.com/jgm/pandoc/releases/download/$PANDOC_VERSION
echo $BASE_URL/$FILE
curl -Ls $BASE_URL/$FILE \
  | tar --directory=/usr/local --strip-components=1 --extract --gunzip --file=-
/usr/local/bin/pandoc --version
