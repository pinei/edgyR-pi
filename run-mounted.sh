#! /bin/bash

# check the password
if [ ${#EDGYR_PASSWORD} -lt 12 ]
then
  echo "You need to specify a new password for the 'edgyr'"
  echo "account in the 'EDGYR_PASSWORD' environment variable."
  echo "The new 'edgyr' password must be at least 12 characters!"
  exit -20
fi

# run L4T images only on Tegra host
if [ `uname -r | grep tegra | wc -l` -le "0" -o `uname -m` != "aarch64" ]
then
  echo "Cannot run - you need to be on an L4T / Tegra host!"
  exit -10
fi

echo "Force-removing old 'edgyr' container"
echo "You can ignore errors if it doesn't exist"
sudo docker rm -f edgyr
echo "Running image edgyr/edgyr:latest"
echo "with $HOME mounted into the container's"
echo "'/home/edgyr'! If this is not what you"
echo "want, press 'CTL-C' in the next 20"
echo "seconds."
sleep 20
sudo docker run --detach \
  --env EDGYR_PASSWORD="$EDGYR_PASSWORD" \
  --network host --name edgyr --hostname edgyr \
  --runtime nvidia \
  --volume $HOME:/home/edgyr \
  "docker.io/edgyr/edgyr:latest"

sleep 10
sudo docker logs edgyr
