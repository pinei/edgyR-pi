#! /bin/bash

sudo docker exec --interactive --tty \
  --user edgyr --workdir /home/edgyr \
  edgyr-pi /bin/bash
