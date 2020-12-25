#! /bin/bash

set -e

echo "Configuring R and pocl"
/sbin/ldconfig --verbose
R CMD javareconf

echo "Configuring RStudio Server"
useradd -r rstudio-server
ln -f -s /usr/local/lib/rstudio-server/bin/rstudio-server /usr/sbin/rstudio-server
mkdir -p /var/run/rstudio-server
mkdir -p /var/lock/rstudio-server
mkdir -p /var/log/rstudio-server
mkdir -p /var/lib/rstudio-server
mkdir -p /etc/rstudio

clinfo
