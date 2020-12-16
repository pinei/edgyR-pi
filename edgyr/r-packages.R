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

# test V8
library(V8)

# Create a new context
ct <- v8()

# Evaluate some code
ct$eval("var foo = 123")
ct$eval("var bar = 456")
if (ct$eval("foo + bar") != 579) { stop(paste0(ct$eval("foo + bar"), " wrong value")) }

# install TinyTeX
tinytex::install_tinytex()
