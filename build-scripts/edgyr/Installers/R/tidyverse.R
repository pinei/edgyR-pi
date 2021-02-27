#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "odbc",
  "RPostgres",
  "RSQLite",
  "tidyerse"
), quiet = TRUE)
warnings()
