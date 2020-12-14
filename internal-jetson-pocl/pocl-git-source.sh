#! /bin/bash -v

set -e

echo "cloning pocl"
rm -fr pocl*
git clone https://github.com/pocl/pocl.git

echo "adding remotes"
pushd pocl
git remote add --fetch Oblomov https://github.com/Oblomov/pocl.git
git remote add --fetch isuruf https://github.com/isuruf/pocl.git
git branch -av
echo "applying patches"
git config --global user.email "znmeb@znmeb.net"
git config --global user.name "M. Edward (Ed) Borasky"
git merge --verbose --commit remotes/isuruf/cuMemHostRegister
git merge --verbose --commit remotes/Oblomov/double-event-wait
popd
