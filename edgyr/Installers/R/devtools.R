Sys.setenv(MAKE = "make --jobs=4")
install.packages(c(
  "devtools",
  "miniUi",
  "pkgdown"
), quiet = TRUE)
