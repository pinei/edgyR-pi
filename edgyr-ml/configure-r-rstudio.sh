#! /bin/bash

set -e

echo "Installing binaries"
cp -rp $BINARIES/bin /usr/local/
cp -rp $BINARIES/lib /usr/local/
cp -rp $BINARIES/include /usr/local/
cp -rp $BINARIES/share /usr/local/

echo "Configuring R"
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
