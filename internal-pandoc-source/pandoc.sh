#! /bin/bash

export PATH=$BINARIES/bin:/root/.cabal/bin:$PATH
cabal --version
ghc --version
echo ""
cabal update

echo "Building 'pandoc' with 'cabal'"
/usr/bin/time cabal install \
  --global \
  --prefix="$BINARIES" \
  --flags="embed_data_files https" \
pandoc
