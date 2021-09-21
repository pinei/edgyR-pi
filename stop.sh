#! /bin/bash

echo "Stopping container 'edgyr-pi'"
sudo docker stop edgyr-pi
echo "Committing 'edgyr-pi' container to 'pinei/edgyr-pi:local'"
sudo docker commit edgyr-pi pinei/edgyr-pi:local
sudo docker images
