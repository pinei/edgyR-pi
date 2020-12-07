#! /bin/bash

set -e

pushd $EDGYR_SRC/$PANDOC_VERSION
cabal v2-build
popd

sudo cp --verbose --dereference $EDGYR_BIN/pandoc /usr/local/bin/pandoc
ldd /usr/local/bin/pandoc
