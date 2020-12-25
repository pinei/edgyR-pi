Sys.setenv(MAKE = "make --jobs=4")
install.packages(c(
  "acs",
  "censusapi",
  "dodgr",
  "ggmap",
  "mapdeck",
  "osmdata",
  "RPostgres",
  "sf",
  "stplanr",
  "tidycensus",
  "tidytransit",
  "tigris",
  "tmap"
), quiet = TRUE)
