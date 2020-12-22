#! /usr/bin/env Rscript

source("~/.Rprofile")
Sys.setenv(MAKE = "make --jobs=4")
update.packages(ask = FALSE, instlib = Sys.getenv("R_LIBS_USER"), quiet = TRUE)
install.packages(c(
  "data.table",
  "devtools",
  "knitr",
  "miniUI",
  "OpenCL",
  "pkgdown",
  "Rcpp",
  "remotes",
  "renv",
  "rmarkdown",
  "rprojroot",
  "tidyverse",
  "tinytex",
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

# test OpenCL
library(OpenCL)
cat("CPUs\n")
print(oclDevices(type = "cpu"))
cat("GPUs\n")
print(oclDevices(type = "gpu"))
p <- oclPlatforms()
if (length(p)) {
  print(oclInfo(p[[1]]))
  d <- oclDevices(p[[1]])
  if (length(d)) {
    print(oclInfo(d))
  }
}

code <- c("
  __kernel void dnorm(
    __global numeric* output,
    const unsigned int count,
    __global numeric* input,
    const numeric mu, const numeric sigma
  )

  {
    size_t i = get_global_id(0);
    if(i < count)
      output[i] = exp(-0.5 * ((input[i] - mu) / sigma) * ((input[i] - mu) / sigma))
        / (sigma * sqrt( 2 * 3.14159265358979323846264338327950288 ) );
  }"
)

for (device_type in c("cpu", "gpu")) {
  cat("\ntesting", device_type, "\n")
  ctx <- oclContext(device = device_type, precision="single")
  print(ctx)
  k.dnorm <- oclSimpleKernel(ctx, "dnorm", code)
  f <- function(x, mu=0, sigma=1) {
    as.numeric(oclRun(k.dnorm, length(x), as.clBuffer(x, ctx), mu, sigma))
  }

  ## expect differences since the above uses single-precision but
  ## it should be close enough
  cat("\nsingle precision\n")
  print(f(1:10/2) - dnorm(1:10/2))

  ## does the device support double-precision?
  if (any("cl_khr_fp64" == oclInfo(attributes(ctx)$device)$exts)) {
    k.dnorm <- oclSimpleKernel(ctx, "dnorm", code, "double")
    f <- function(x, mu=0, sigma=1) {
      buf <- clBuffer(ctx, length(x), "double")
      buf[] <- x
      as.numeric(oclRun(k.dnorm, length(x), buf, mu, sigma))
    }

    ## probably not identical, but close...
    cat("\ndouble precision\n")
    print(f(1:10/2) - dnorm(1:10/2))

  } else {
    cat("\nSorry, your device doesn't support double-precision\n")
  }
}
cat("\n\n")

# install TinyTeX
tinytex::install_tinytex()
tinytex::tlmgr_conf()
