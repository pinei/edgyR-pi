#! /bin/bash

set -e

cd $SOURCE_DIR
wget -q -O - https://downloads.haskell.org/~ghc/$GHC_RELEASE/ghc-$GHC_RELEASE-src.tar.xz \
  | tar xJf -
pushd ghc-$GHC_RELEASE
  pushd mk
    cp build.mk.sample build.mk
    sed --in-place=.bak 's/\#BuildFlavour = quick$/BuildFlavour = quick/' build.mk
    diff build.mk.sample build.mk
  popd

  ./boot
  ./configure
  make
  make install
popd
