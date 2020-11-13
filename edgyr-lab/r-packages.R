#! /usr/bin/env Rscript

source("~/.Rprofile")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "caracas",
  "data.table",
  "IRkernel",
  "keras",
  "knitr",
  "remotes",
  "renv",
  "rmarkdown",
  "rprojroot",
  "rTorch",
  "tinytex"
), quiet = TRUE)

IRkernel::installspec()
tinytex::install_tinytex()
