#! /bin/bash

cabal --version
ghc --version
echo ""
cabal v2-update

echo "Building 'pandoc' with 'cabal'"
/usr/bin/time cabal v2-install \
  --installdir=/usr/local/bin \
  --disable-optimization \
  --overwrite-policy=always \
  --flags="embed_data_files https" \
pandoc
