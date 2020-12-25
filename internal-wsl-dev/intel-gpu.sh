#! /bin/bash

# https://dgpu-docs.intel.com/installation-guides/ubuntu/ubuntu-focal.html
wget -qO - https://repositories.intel.com/graphics/intel-graphics.key \
  | apt-key add -
apt-add-repository \
  'deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main'
apt-get update
apt-get install -qqy --no-install-recommends \
  intel-opencl-icd \
  intel-level-zero-gpu level-zero \
  intel-media-va-driver-non-free libmfx1
  libigc-dev \
  libigdfcl-dev \
  libigfxcmrt-dev \
  intel-igc-opencl-devel \
  level-zero-devel level-zero-dev
