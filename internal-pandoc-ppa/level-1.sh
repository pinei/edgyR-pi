#! /bin/bash

set -e

function install {
  echo "install $1"
  rm -fr $SOURCE_DIR/$1-build
  mkdir $SOURCE_DIR/$1-build
  pushd $SOURCE_DIR/$1-build
    apt-get build-dep -y $1 >> $LOGS/$1.log 2>&1
    /usr/bin/time apt-get source --compile $1 >> $LOGS/$1.log 2>&1
    apt-get install -qqy --no-install-recommends ./$1_*.deb >> $LOGS/$1.log 2>&1
    cp *deb $PACKAGES/
    cp *dsc $PACKAGES/
  popd
  zip -9rmyq $SOURCE_DIR/$1-build.zip $1-build
  echo "install done $1"
}

cd $SOURCE_DIR
install haskell-ansi-wl-pprint
install haskell-cmark-gfm
install haskell-doctemplates
install haskell-hspec-core
install haskell-optparse-applicative
install haskell-pandoc-types
install haskell-tagsoup
install haskell-test-framework
install haskell-texmath
install haskell-wcwidth
