#! /bin/bash

# RStudio uses 'soci' to connect to PostgreSQL and SQLite.
# However, the PostgreSQL client libraries in Bionic / L4t
# are for PostgreSQL 10, and won't work with newer versions.
# So we install the PostgreSQL Global Development Group
# (PGDG) repository.
echo "Installing PGDG Linux repository"
# https://wiki.postgresql.org/wiki/Apt
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo cp $SCRIPTS/pgdg.list /etc/apt/sources.list.d/pgdg.list
sudo apt-get update
sudo apt-get upgrade -y
