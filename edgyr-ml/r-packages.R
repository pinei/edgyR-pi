#! /usr/bin/env Rscript

source("~/.Rprofile")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "data.table",
  "reticulate",
  "knitr",
  "remotes",
  "renv",
  "rmarkdown",
  "rprojroot",
  "tinytex"
), quiet = TRUE)

tinytex::install_tinytex()
