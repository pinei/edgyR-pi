#! /usr/bin/env Rscript

source("~/.Rprofile")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "bookdown",
  "caracas",
  "data.table",
  "devtools",
  "distill",
  "IRkernel",
  "keras",
  "knitr",
  "learnr",
  "miniUI",
  "pkgdown",
  "plumber",
  "remotes",
  "renv",
  "rmarkdown",
  "rprojroot",
  "rTorch",
  "shiny",
  "tidyverse",
  "tinytex"
), quiet = TRUE)

IRkernel::installspec()
tinytex::install_tinytex()
