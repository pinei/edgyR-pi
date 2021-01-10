Sys.setenv(MAKE = "make --jobs=4")
install.packages(c(
  "blogdown",
  "bookdown",
  "distill",
  "flexdashboard",
  "learnr",
  "revealjs",
  "rticles",
  "tufte",
  "xaringan"
), quiet = TRUE)
