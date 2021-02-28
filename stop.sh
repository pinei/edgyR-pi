#! /bin/bash

echo "Stopping container 'edgyr'"
sudo docker stop edgyr
echo "Committing 'edgyr' container to 'edgyr/edgyr:local'"
sudo docker commit edgyr edgyr/edgyr:local
sudo docker images
