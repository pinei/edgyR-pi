#! /usr/bin/env Rscript

Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "data.table",
  "devtools",
  "flexdashboard",
  "learnr",
  "miniUI",
  "pkgdown",
  "renv",
  "reticulate",
  "shiny",
  "sodium",
  "tinytex"
), repos = "https://cloud.r-project.org/", quiet = TRUE)
warnings()
