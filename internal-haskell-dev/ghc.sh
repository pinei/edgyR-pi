#! /bin/bash

set -e

cd $SOURCE_DIR
wget -q -O - https://downloads.haskell.org/~ghc/$GHC_RELEASE/ghc-$GHC_RELEASE-src.tar.xz \
  | tar xJf -
pushd ghc-$GHC_RELEASE
  ./configure
  /usr/bin/time make --jobs=`nproc`
  make install
popd
