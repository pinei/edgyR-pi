#! /usr/bin/env Rscript

source("~/.Rprofile")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "data.table",
  "reticulate",
  "knitr",
  "Rcpp",
  "remotes",
  "renv",
  "rmarkdown",
  "rprojroot",
  "tinytex",
  "V8"
), quiet = TRUE)

source("~/Installers/R/test-V8.R")

tinytex::install_tinytex()
