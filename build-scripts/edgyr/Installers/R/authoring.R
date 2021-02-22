#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "blogdown",
  "bookdown",
  "DiagrammeR",
  "distill",
  "flexdashboard",
  "learnr",
  "revealjs",
  "rticles",
  "tufte",
  "xaringan"
), quiet = TRUE)
warnings()
