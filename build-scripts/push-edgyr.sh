#! /bin/bash

set -e

export EDGYR_RELEASE=0.7.4.9999
sudo docker push "edgyr/edgyr:latest"
if [ ${#EDGYR_RELEASE} -gt "0" ]
then 
  sudo docker tag "edgyr/edgyr:latest" "edgyr/edgyr:$EDGYR_RELEASE"
  sudo docker push "edgyr/edgyr:$EDGYR_RELEASE"
fi
