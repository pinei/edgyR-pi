#! /bin/bash

cd $SOURCE_DIR
wget -q -O - https://downloads.haskell.org/~ghc/$GHC_RELEASE/ghc-$GHC_RELEASE-src.tar.xz \
  | tar xJf -
cp $SCRIPTS/build.mk ghc-$GHC_RELEASE/mk/
pushd ghc-$GHC_RELEASE
  ./boot
  ./configure
  make install
popd
