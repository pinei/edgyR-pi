#! /bin/bash

set -e

sudo docker login
export EDGYR_RELEASE=0.9.4.9999
for image in \
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

echo "Fixing up permissions"
sudo chown -R $USER:$USER $HOME/.docker
