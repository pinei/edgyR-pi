#! /bin/bash

echo "Installing golang binary"
cd $SOURCE_DIR
curl -Ls https://golang.org/dl/go$GOLANG_VERSION.linux-arm64.tar.gz \
  | tar --directory /usr/local -xzf -
export PATH=$PATH:/usr/local/go/bin

echo "Installing Hugo"
rm -fr hugo*
git clone https://github.com/gohugoio/hugo.git
cd hugo
/usr/bin/time go install --tags extended
cp /root/go/bin/hugo /usr/local/bin/
ldd /usr/local/bin/hugo
hugo version
rm -fr hugo
