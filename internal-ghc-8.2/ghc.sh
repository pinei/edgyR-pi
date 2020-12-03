#! /bin/bash

cd $EDGYR_SRC
wget -q -O - https://downloads.haskell.org/~ghc/$GHC_RELEASE/ghc-$GHC_RELEASE-src.tar.xz \
  | tar xJf -
pushd ghc-$GHC_RELEASE
  if [ "$1" = "quick" ]
  then
    pushd mk
      cp build.mk.sample build.mk
      sed --in-place=.bak 's/\#BuildFlavour = quick$/BuildFlavour = quick/' build.mk
      diff build.mk.sample build.mk
    popd
  fi

  set -e

  ./boot
  ./configure

  # The Nano only has 4 GB of RAM. As a result, the GHC builds swamp the available
  # RAM and multi-job makes are problematic - they swap and the system appears
  # unresponsive.
  #
  # So we only run two-job makes if we have less than 7 GB of RAM.
  export RAM_KILOBYTES=`grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'`
  if [ $RAM_KILOBYTES -ge "7000000" ]
  then
    export JOBS=`nproc`
  else
    export JOBS=2
  fi
  echo "Installing"
  echo " -- starting GHC builds"
  echo " -- RAM_KILOBYTES = $RAM_KILOBYTES; 'make' will use $JOBS jobs."

  /usr/bin/time make --jobs=$JOBS
  sudo make install
popd
sudo rm -fr $EDGYR_SRC/ghc-*
