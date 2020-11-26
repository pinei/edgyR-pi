#! /bin/bash

# run L4T images only on Tegra host
if [ `uname -r | grep tegra | wc -l` -le "0" -o `uname -m` != "aarch64" ]
then
  echo "Cannot run - you need to be on an L4T / Tegra host!"
  exit -10
fi

echo $EDGYR_PASSWORD
echo "Force-removing old 'edgyr' container"
echo "You can ignore errors if it doesn't exist"
sudo docker rm -f edgyr
echo "Running image edgyr/edgyr-ml:latest"
sudo docker run --interactive --tty \
  --network host --name edgyr --hostname edgyr \
  --runtime nvidia \
  "docker.io/edgyr/edgyr-ml:latest"

sleep 10
sudo docker logs edgyr
