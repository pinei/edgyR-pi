#! /bin/bash

set -e

export WEBSITE="https://hackage.haskell.org/package"

pushd $EDGYR_SRC
wget -q -O - $WEBSITE/$PANDOC_VERSION/$PANDOC_VERSION.tar.gz \
  | tar xzf -
cd $PANDOC_VERSION

# see https://github.com/jgm/pandoc/blob/2.11.2/linux/make_artifacts.sh
# and https://github.com/jgm/pandoc/blob/master/INSTALL.md
cabal user-config update
cabal v2-update
cabal v2-clean
cabal v2-install \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --ghc-options "-optc-Os -optl=-pthread" \
  --only-dependencies

cabal v2-configure \
  --disable-coverage \
  --disable-debug-info \
  --disable-documentation \
  --disable-executable-dynamic \
  --disable-optimization \
  --disable-profiling \
  --disable-shared \
  --disable-tests \
  --flags="embed_data_files https" \
  --ghc-options "-optc-Os -optl=-pthread" \
popd
