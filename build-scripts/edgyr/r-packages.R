#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = "make --jobs=4")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "bookdown",
  "caracas",
  "data.table",
  "devtools",
  "knitr",
  "miniUI",
  "pkgdown",
  "Rcpp",
  "remotes",
  "renv",
  "rmarkdown",
  "rprojroot",
  "tidyverse",
  "tinytex",
  "tufte",
  "V8"
), quiet = TRUE)

# test V8
cat("\ntesting V8\n")
library(V8)
ct <- v8()
ct$eval("var foo = 123")
ct$eval("var bar = 456")
if (ct$eval("foo + bar") != 579) {
  stop(paste0(ct$eval("foo + bar"), " wrong value - should be 579"))
} else {
  cat("\nV8 is working\n\n")
}

# install TinyTeX
tinytex::install_tinytex()
tinytex::tlmgr_conf()
