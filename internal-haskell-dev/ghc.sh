#! /bin/bash

cd $EDGYR_SRC
wget -q -O - https://downloads.haskell.org/~ghc/$GHC_RELEASE/ghc-$GHC_RELEASE-src.tar.xz \
  | tar xJf -
pushd ghc-$GHC_RELEASE
if [ "$1" .eq "quick" ]
then
  pushd mk
    cp build.mk.sample build.mk
    sed --in-place=.bak 's/\#BuildFlavour = quick$/BuildFlavour = quick/' build.mk
    diff build.mk.sample build.mk
  popd
fi

  set -e

  ./boot
  ./configure
  /usr/bin/time make --jobs=`nproc`
  sudo make install
popd
