#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = "make --jobs=4")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "audio",
  "blogdown",
  "bookdown",
  "caracas",
  "data.table",
  "devtools",
  "DiagrammeR",
  "distill",
  "flexdashboard",
  "knitr",
  "learnr",
  "miniUI",
  "monitoR",
  "NatureSounds",
  "odbc",
  "phonTools",
  "pkgdown",
  "Rcpp",
  "remotes",
  "renv",
  "revealjs",
  "rmarkdown",
  "RPostgres",
  "rprojroot",
  "RSQLite",
  "rticles",
  "seewave",
  "servr",
  "sf",
  "signal",
  "soundecology",
  "soundgen",
  "sp",
  "testthat",
  "tidyverse",
  "tinytex",
  "tufte",
  "tuneR",
  "V8",
  "webshot",
  "xaringan"
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
