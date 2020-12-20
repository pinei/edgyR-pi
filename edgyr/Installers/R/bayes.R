install.packages(c(
  "coda",
  "dagitty",
  "mvtnorm"
), quiet = TRUE)
install.packages("rstan", dependencies = TRUE, quiet = TRUE)
example(stan_model, package = "rstan", run.dontrun = TRUE)
remotes::install_github("rmcelreath/rethinking", quiet = TRUE)
