#! /usr/bin/env Rscript

Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "data.table",
  "devtools",
  "flexdashboard",
  "miniUI",
  "pkgdown",
  "renv",
  "reticulate",
  "shiny",
  "sodium",
  "tinytex"
), quiet = TRUE)
warnings()
