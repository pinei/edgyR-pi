#! /bin/bash

cp $SCRIPTS/R.conf /etc/ld.so.conf.d/R.conf
/sbin/ldconfig --verbose
R CMD javareconf
