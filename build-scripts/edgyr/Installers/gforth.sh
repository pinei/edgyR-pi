#! /bin/bash

set -e

echo "Installing build dependencies"
apt-get install -qqy --no-install-recommends \
  a2ps \
  info \
  texinfo
apt-get clean

echo "Fetching gforth source tarball"
curl -Ls \
  https://ftp.gnu.org/gnu/gforth/gforth-$GFORTH_VERSION.tar.gz \
  | tar xzf -
cd gforth-$GFORTH_VERSION/

echo "Updating configuration tools"
curl -Ls \
  http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess \
  > config.guess
curl -Ls \
  http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub \
  > config.sub

echo "Configuring"
./configure 

echo "Compiling"
make

echo "Installing"
make install

echo "Cleanup"
cd ..
rm -fr gforth-$GFORTH_VERSION/
