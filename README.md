# edgyR-pi: Docker Images for Raspberry Pi R Developers

## Introduction

The `edgyR` project was designed by M. Edward (Ed) Borasky <znmeb@znmeb.net>
to make R a first-class language for edge computing developers (arm64/aarch64
architecture). It is forged to run in `NVIDIA Jetson Nano` cluster and applied
to digital audio synthesis.

This `edgyR-pi` project is a minimalist port for `Raspberry Pi` developers.

## How is `edgyR` pronounced?

There are (at least) five options:

1.  ED-grrr

2.  ED-gyre

3.  EDGE-er

4.  Edgier

5.  Edgy R

It is ***not*** pronounced like any brand of peanut butter. Otherwise,
it's your choice!

## Getting set up

1.  Buy a [Raspberry Pi 4](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/).

    -   Raspberry Pi 4 has a quad-core ARMv8 64-bit CPU.

    -   4 GB RAM: This is the minimum recommended environment for `edgyR`.
        I use a 64 GB microSD card and an external 1 TB hard drive.

2.  Set up Docker runtime

3.  Just about everything you'd ever want is available via `docker run` or
    `sudo apt install` in Linux, and `install.packages` or `devtools::install` in R.

    If you want more - `arm64` binaries downloaded from upstream
    projects or built from upstream source for

    -   `pandoc` 2.11.2,

    -   R 4.0.4 with `tidyverse`, R Markdown, ShinyⓇ, and  `reticulate`,

    -   [RStudioⓇ Server
        1.4](https://rstudio.com/products/rstudio/download-server/other-platforms/ "Download RStudio Server for other platforms"),

    -   [`libnode-dev`](https://launchpad.net/~cran/+archive/ubuntu/v8 "v8 (libnode) PPA")
        for the `V8` R package,

    -   [`conda-forge`](https://github.com/conda-forge/miniforge "conda-forge/miniforge GitHub repository"),

    all on a Docker image, then read on!

4. Set up a swap memory (we will need for the building to avoid Out of Memory error)

    -   As an Ubuntu user, I followed this tutorial from somewhere in `Digital Ocean community`.


    ```
    # if the system has any configured swap
    $ sudo swapon --show

    # see if there is no active swap
    $ free -h

    # check available space
    $ df -h

    # creates a file for the swap memory (just used 1 GB, didn't check the recommendations)
    $ sudo fallocate -l 1G /swapfile

    # check the current amount of space that was resserved
    $ ls -lh /swapfile

    # make accessible to root
    $ sudo chmod 600 /swapfile

    # mark the file as swap space
    $ sudo mkswap /swapfile

    # enable the swap file
    $ sudo swapon /swapfile
    
    # verify that the swap is available
    $ sudo swapon --show
    
    # also check with the free utility
    $ free -h
    ```

## Licensing

Because the `edgyR` Docker image redistributes RStudio Server in binary
form, it uses the same license as RStudio - the [GNU Affero General
Public
License](https://www.gnu.org/licenses/agpl-3.0.en.html "GNU Affero General Public License").
This essentially means I have to make all the source code I've modified
to anyone who wants it.

For `edgyR`, that comprises two places:

-   the code in this repository, mostly Dockerfiles and `bash` scripts,
    and

-   some directories on the internal builder images, which reside in the [Docker Hub `pinei`
    organization](https://hub.docker.com/orgs/pinei/repositories).
s
## Contributing

Contributing to the project is really quite simple:

1.  Read the code of conduct at
    <https://github.com/pinei/edgyR-pi/blob/master/CODE_OF_CONDUCT.md>.

2.  Everything starts with an issue. See [Always start with an
    issue](https://about.gitlab.com/2016/03/03/start-with-an-issue/) for
    the philosophy.

    -   Is the documentation unclear? [File an
        issue](https://github.com/pinei/edgyR-pi/issues/new).
    -   Did you find a bug? [File an
        issue](https://github.com/pinei/edgyR-pi/issues/new).
    -   Do you want to request a feature? [File an
        issue](https://github.com/pinei/edgyR-pi/issues/new).

*Please, don't go through the mechanics of forking / pull requests even
for trivial typo changes without filing an issue. [File an
issue](https://github.com/pinei/edgyR-pi/issues/new).*

# [***Yes! I want more!***](https://github.com/pinei/edgyR-pi/blob/main/I-want-more.md)
