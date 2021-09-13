#! /bin/bash

set -e

apt-get update
apt-get upgrade -y
apt-get install -qqy --no-install-recommends \
  i2c-tools \
  libi2c-dev \
  sudo \
  tzdata
apt-get clean

useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,i2c,plugdev,sudo,video \
  --create-home \
  --uid 1000 edgyr \
  && echo "edgyr:edgyr" | chpasswd
