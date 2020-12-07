#! /bin/bash

set -e

pushd $EDGYR_SRC/$PANDOC_VERSION
cabal v2-build
cabal v2-install
popd

sudo cp --verbose --dereference $EDGYR_BIN/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc
