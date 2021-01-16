# edgyR-containers: Docker Images for NVIDIA Jetson R Developers

## About the images
* [docker.io/edgyr/edgyr](https://hub.docker.com/r/edgyr/edgyr): This is the
main user-level image. It contains
    - the `L4T` base, 
    - `pandoc`, `R` and `RStudio Server` built from source,
    - `miniforge`, `JupyterLab` and the Python data science stack,
    - `cupy` and `cusignal`,
    - R library packages for data science, documentation, package development,
        and interfacing with Python data science tools, and
    - installers for common add-ons.
* [docker.io/edgyr/internal-ubuntu-builder](https://hub.docker.com/repository/docker/edgyr/internal-ubuntu-builder): This image contains all the binaries built from source
required by `edgyr`. You will only need this if you want to build your own
local version of some of the binaries on `edgyr`.
* [docker.io/edgyr/internal-pandoc](https://hub.docker.com/r/edgyr/internal-pandoc):
This image contains the `Pandoc` executable and the scripts to build it. You
will only need this if you want to build your own local versions of
`internal-ubuntu-builder`, `edgyr` or both. 

* build-scripts
* edgyR-containers.Rproj
* LICENSE
* login-as-edgyr.sh
* login-as-root.sh
* pull.sh
* README.md
* run.sh
* build-all.sh
* build.sh
* edgyr
* internal-pandoc
* internal-ubuntu-builder
* pull.sh
* push.sh
* 