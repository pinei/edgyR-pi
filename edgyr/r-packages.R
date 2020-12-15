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

tinytex::install_tinytex()

# test V8
library(V8)

# Create a new context
print(ct <- v8())

# Evaluate some code
print(ct$eval("var foo = 123"))
print(ct$eval("var bar = 456"))
print(ct$eval("foo + bar"))
cat(ct$eval("JSON.stringify({x:Math.random()})"))
print(ct$eval("(function(x){return x+1;})(123)"))
