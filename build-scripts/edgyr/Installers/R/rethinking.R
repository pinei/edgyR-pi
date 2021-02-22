#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
install.packages(c(
  "coda",
  "dagitty"
), quiet = TRUE)
warnings()
install.packages("rstan", dependencies = TRUE, quiet = TRUE)
warnings()
remotes::install_github("rmcelreath/rethinking", quiet = TRUE)
warnings()

# test rstan
example(stan_model, package = "rstan", run.dontrun = TRUE)
