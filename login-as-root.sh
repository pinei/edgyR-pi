#! /bin/bash

sudo docker exec --interactive --tty \
  --user root --workdir /usr/local/src \
  edgyr-pi /bin/bash
