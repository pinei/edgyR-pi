#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
tinytex::install_tinytex()
tinytex::tlmgr_conf()
