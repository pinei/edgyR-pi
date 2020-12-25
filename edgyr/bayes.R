#! /usr/bin/env Rscript

# define a RAM query function
ram_kilobytes <- function() {
  as.numeric(
    sub(pattern = "kB", replacement = "", sub(pattern = "MemTotal:", replacement = "",
      system('grep MemTotal /proc/meminfo', intern = TRUE)
    ))
  )
}

if (ram_kilobytes() < 7000000) {
  Sys.setenv(MAKE = "make --jobs=1")
} else {
  Sys.setenv(MAKE = "make --jobs=4")
}

install.packages(c(
  "coda",
  "dagitty",
  "mvtnorm"
), quiet = TRUE)
install.packages("rstan", dependencies = TRUE, quiet = TRUE)
example(stan_model, package = "rstan", run.dontrun = TRUE)
remotes::install_github("rmcelreath/rethinking", quiet = TRUE)
