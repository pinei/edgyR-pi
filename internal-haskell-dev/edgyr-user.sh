#! /bin/bash

set -e

useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,i2c,plugdev,sudo,video \
  --create-home \
  --uid 1000 edgyr \
  && echo "edgyr:edgyr" | chpasswd
