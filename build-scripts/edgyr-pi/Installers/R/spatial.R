#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "acs",
  "censusapi",
  "dodgr",
  "ggmap",
  "mapdeck",
  "maps",
  "osmdata",
  "sf",
  "sp",
  "stplanr",
  "tidycensus",
  "tidytransit",
  "tigris",
  "tmap"
), quiet = TRUE)
warnings()
