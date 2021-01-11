Sys.setenv(MAKE = "make --jobs=4")
install.packages(c(
  "blogdown",
  "distill",
  "flexdashboard",
  "learnr",
  "revealjs",
  "rticles",
  "xaringan"
), quiet = TRUE)
