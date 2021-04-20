#! /bin/bash

set -e

#export CMAKE_VERSION="3.20.0"
export XPRA_VERSION="4.1.2"
./xpra-packages/package-xpra.sh

export XPRA_HTML5_VERSION="4.1.2"
./xpra-packages/package-xpra-html5.sh
