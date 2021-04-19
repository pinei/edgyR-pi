#! /bin/bash

echo "Installing golang binary"
curl -Ls https://golang.org/dl/go$GOLANG_VERSION.linux-arm64.tar.gz \
  | sudo tar --directory /usr/local -xzf -
sudo ln -sf /usr/local/go/bin/* /usr/local/bin/

echo "Installing Hugo"
pushd $HOME/Projects

  rm -fr hugo*
  git clone https://github.com/gohugoio/hugo.git
  cd hugo
  /usr/bin/time go install --tags extended
  hugo version
  popd

echo "Installing blogdown"
Rscript -e "install.packages('blogdown', quiet = TRUE)"
