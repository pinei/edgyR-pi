#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "tinytex"
), quiet = TRUE)
warnings()

tinytex::install_tinytex()
tinytex::tlmgr_conf()
