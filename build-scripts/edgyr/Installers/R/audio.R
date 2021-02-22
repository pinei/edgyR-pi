#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "audio",
  "monitoR",
  "NatureSounds",
  "phonTools",
  "seewave",
  "signal",
  "soundecology",
  "soundgen",
  "tuneR"
), quiet = TRUE)
warnings()
remotes::install_github("maRce10/warbleR", quiet = TRUE)
warnings()
