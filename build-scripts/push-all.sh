#! /bin/bash

set -e

sudo docker login
export EDGYR_RELEASE=0.9.5
for image in \
  internal-ubuntu-builder \
  edgyr-pi
do
  sudo docker push "pinei/$image:latest"
  if [ ${#EDGYR_RELEASE} -gt "0" ]
  then 
    sudo docker tag "pinei/$image:latest" "pinei/$image:$EDGYR_RELEASE"
    sudo docker push "pinei/$image:$EDGYR_RELEASE"
  fi
done

echo "Fixing up permissions"
sudo chown -R $USER:$USER $HOME/.docker
