#! /bin/bash

set -e

function install {
  echo "install $1"
  rm -fr $SOURCE_DIR/$1-build
  mkdir $SOURCE_DIR/$1-build
  pushd $SOURCE_DIR/$1-build
    apt-get build-dep -y $1 >> $LOGS/$1.log 2>&1
    /usr/bin/time apt-get source --compile $1 >> $LOGS/$1.log 2>&1
    apt-get install -qqy --no-install-recommends ./*_*.deb >> $LOGS/$1.log 2>&1
    cp *deb $PACKAGES/
    cp *dsc $PACKAGES/
  popd
  zip -9rmyq $SOURCE_DIR/$1-build.zip $1-build
  echo "install done $1"
}

cd $SOURCE_DIR
install haskell-tasty
install haskell-tasty-expected-failure
install haskell-tasty-golden
install haskell-tasty-hunit
install haskell-tasty-kat
install haskell-tasty-quickcheck
install haskell-tasty-smallcheck
install haskell-skylighting
install haskell-skylighting-core
install haskell-hslua
install haskell-hslua-module-text
