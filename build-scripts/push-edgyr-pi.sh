#! /bin/bash

set -e

sudo docker login
export EDGYR_RELEASE=0.9.5
sudo docker push "pinei/edgyr-pi:latest"
if [ ${#EDGYR_RELEASE} -gt "0" ]
then 
  sudo docker tag "pinei/edgyr-pi:latest" "pinei/edgyr-pi:$EDGYR_RELEASE"
  sudo docker push "pinei/edgyr-pi:$EDGYR_RELEASE"
fi

echo "Fixing up permissions"
sudo chown -R $USER:$USER $HOME/.docker
