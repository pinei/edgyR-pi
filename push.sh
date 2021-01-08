#! /bin/bash

set -e

export EDGYR_RELEASE=0.7.4.9999
for image in \
  internal-pandoc \
  internal-ubuntu-builder \
  edgyr
do
  sudo docker push "edgyr/$image:latest"
  if [ ${#EDGYR_RELEASE} -gt "0" ]
  then 
    sudo docker tag "edgyr/$image:latest" "edgyr/$image:$EDGYR_RELEASE"
    sudo docker push "edgyr/$image:$EDGYR_RELEASE"
  fi
done
