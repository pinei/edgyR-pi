#! /bin/bash

# check the password
if [ ${#EDGYR_PASSWORD} -lt 12 ]
then
  echo "You need to specify a new password for the 'edgyr'"
  echo "account in the 'EDGYR_PASSWORD' environment variable."
  echo "The new 'edgyr' password must be at least 12 characters!"
  exit -20
fi

echo "Force-removing old 'edgyr-pi' container"
echo "You can ignore errors if it doesn't exist"
sudo docker rm -f edgyr-pi
echo "Running image 'pinei/edgyr-pi:latest' in container 'edgyr-pi'"
sudo docker run --detach \
  --env EDGYR_PASSWORD="$EDGYR_PASSWORD" \
  --network host --name edgyr-pi \
  "docker.io/pinei/edgyr-pi:latest"

sleep 5
sudo docker logs edgyr
