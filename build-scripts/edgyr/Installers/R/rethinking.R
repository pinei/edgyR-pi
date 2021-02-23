#! /usr/bin/env Rscript

source("~/.Rprofile")

# 'rstan' can generate large C code files, which it hands off
# to 'gcc'. The resulting 'gcc' jobs can swamp RAM on the 
# Nano. So we limit ourselves to one 'make' job if we have
# less than 7,000,000 kilobytes of RAM.
if (as.numeric(Sys.getenv("SYSTEM_RAM_KILOBYTES")) < 7000000) {
  Sys.setenv(MAKE = paste0("make --jobs=1"))
} else { 
  Sys.setenv(MAKE = paste0("make --jobs=", parallel::detectCores()))
}

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
