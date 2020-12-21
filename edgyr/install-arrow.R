#! /usr/bin/env Rscript

install.packages(c(
  "arrow",
  "reticulate"
), quiet = TRUE)

library(reticulate)
use_condaenv("r-reticulate")

cat("\ntesting arrow\n")
library(arrow)
pa <- import("pyarrow")
a <- pa$array(c(1, 2, 3))
print(a)
print(a[a > 1])
b <- Array$create(c(5, 6, 7, 8, 9))
a_and_b <- pa$concat_arrays(list(a, b))
print(a_and_b)
