Sys.setenv(MAKE = "make --jobs=4")
install.packages(c(
  "devtools",
  "miniUI",
  "pkgdown"
), quiet = TRUE)
