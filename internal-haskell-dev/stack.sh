#! /bin/bash

export PATH=/root/.cabal/bin:/root/.local/bin:$PATH
stack update
stack upgrade
