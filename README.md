# edgyR-containers: Docker Images for NVIDIAⓇ Jetson™ R Developers

## Update -- 2021-02-23
I've finished the "de-enhancement" process and will be releasing
v0.9.5 in the very near future. The biggest change is that I've removed some
features that are problematic on the 4 GB Nano. The image is larger than I'd
like - 7.75 gigabytes - but it is packed to the brim with goodies via the
latest release of 
[NVIDIA L4T ML](https://ngc.nvidia.com/catalog/containers/nvidia:l4t-ml).

## Update -- 2021-02-12
I'm pausing enhancements on this project for a while. I will continue to update
versions for R, RStudio Server, Miniforge and all the other components on the
`edgyr` image and the installers, but I won't be adding new functionality.

There are two reasons:
1. I've been unable to find a readily-available CI/CD service for Ubuntu 18.04
`arm64` Docker builds. So whenever something changes, I have to do a build
on my AGX Xavier, which is a single point of failure.
2. I want to spend more time on digital music synthesis with the Jetson Nano.
While that can be done within this project, `edgyR` is overkill for what I
want to do there.

## Introduction

> “And though she be but little, she is fierce.” – Shakespeare, on
> receiving an NVIDIA Jetson Nano for his birthday

The `edgyR` project is designed to make R a first-class language for
edge computing developers. My initial motivation was to build a Jetson
Nano cluster and use it for digital audio synthesis. Since R is my
strongest language - I haven't used Fortran since 1990, I don't know
*any* C++ and can barely copy-and-paste Python in Jupyter notebooks, the
initial step was to buy a Jetson and set about making the tools in
[*Sound Analysis and Synthesis with
R*](https://www.springer.com/us/book/9783319776453 "Springer Sound Analysis and Synthesis with R page")
work on it.

That was February 2020 - since then, there's been a few things going on
in the outside world, and I discovered just how powerful the Jetson
platform is. And [I wanted
more!](https://media.giphy.com/media/D3OdaKTGlpTBC/giphy.gif) So I built
this thing called [edgyR: R on the
Edge](https://github.com/edgyR "edgyR: R on the Edge GitHub organization").

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

1.  Buy a [Jetson Developer
    Kit](https://developer.nvidia.com/embedded/jetson-developer-kits "NVIDIA Jetson Developer Kits").
    There are four models:

    -   Jetson Nano 2 GB RAM: You probably don't want this one. I don't
        test on it and I've had a few jobs fail on the 4 GB Nano for
        lack of RAM.

        Linux behaves gracelessly with insufficient RAM. It will either
        kill running processes it thinks are problematic, or thrash
        uncontrollably, swapping pages in and out. Both will waste your
        time.

    -   Jetson Nano 4 GB RAM: This is the minimum recommended
        environment for `edgyR`. It has four cores, 4 GB of RAM, and an
        NVIDIA Maxwell GPU with 128 CUDAⓇ cores.

        The Nano uses a microSD card for storage. You will probably want
        a larger microSD card than the minimum required. I use a 256 GB
        microSD card for mine.

    -   Jetson Xavier NX: This has six cores, 8 GB of RAM, and an NVIDIA
        Volta GPU with 384 CUDA cores and 48 tensor cores. It also has
        specialized NVIDIA vision processing hardware. Like the Nano, it
        uses microSD for storage and you will want a large one.

        If you have the money I recommend this one over the Nano. It's
        much more powerful and still has the connectivity and
        interfacing capabilities of the Nano. And there are some very
        useful NVIDIA packages, such as
        [RAPIDS.AI](https://rapids.ai/ "RAPIDS.AI"), that won't run on
        the Nano because the Maxwell GPU doesn't support them.

    -   Jetson AGX Xavier: This has eight cores, 32 GB of RAM and an
        NVIDIA Volta GPU with 512 CUDA cores and 64 tensor cores, and
        the NVIDIA specialized vision processing hardware.

        I have an older model with only 16 GB of RAM that I use for
        building the images. With a keyboard and monitor this is a great
        little workstation. The storage setup is a bit tricky, though,
        so unless you need the horsepower I'd recommend the Xavier NX.

2.  Set up the Jetson. The [NVIDIA
    documentation](https://developer.nvidia.com/embedded/learn/getting-started-jetson "NVIDIA Jetson getting started")
    is first-class, and the [NVIDIA Jetson developer support
    forum](https://forums.developer.nvidia.com/c/agx-autonomous-machines/jetson-embedded-systems/70 "NVIDIA Jetson developer support forum")
    will fill in the blanks. For hardware hacking, the
    [JetsonHacks](https://www.jetsonhacks.com/ "JetsonHacks website")
    website is the place to go.

    The setup process for the Nano and Xavier NX involves connecting a
    keyboard and monitor, connecting to your home / lab LAN and flashing
    a microSD card. It's a bit trickier on the AGX Xavier because you
    need an external Ubuntu 18.04 LTS system to flash the boot firmware
    and a way to expand the storage.

    When you're done, you'll have an `arm64` / `aarch64` workstation
    with an NVIDIA GPU. The Jetson software is called
    [JetPack](https://developer.nvidia.com/embedded/jetpack "JetPack SDK").
    JetPack includes:

    -   [Linux for Tegra
        (L4T)](https://developer.nvidia.com/embedded/linux-tegra "L4T website"):
        This is Ubuntu 18.04 LTS "Bionic Beaver" for the
        `arm64`architecure plus NVIDIA extensions,

    -   the NVIDIA Docker runtime, and

    -   NVIDIA drivers, compilers, libraries, and applications that can
        use the Jetson hardware.

    Because JetPack includes the NVIDIA Docker runtime, it can run any
    image in the [NVIDIA NGC L4T container
    catalog](https://ngc.nvidia.com/catalog/containers?orderBy=scoreDESC&pageNumber=0&query=L4T&quickFilter=containers&filters= "NVIDIA NGC container catalog")
    (link may open in a new window for security) that is compatible with
    your Jetson.

3.  ***If you're a Python programmer, or an R programmer that can live
    with `R version 3.4.4 (2018-03-15) -- "Someone to Lean On"` and
    `pandoc 1.19.2.4` from the command line, you're done!*** Just about
    everything you'd ever want is available via `docker run` or
    `sudo apt install` in Linux, and `install.packages` or
    `devtools::install` in R.

    If you want more - `arm64` binaries downloaded from upstream
    projects or built from upstream source for

    -   `pandoc` 2.11.2,

    -   R 4.0.4 with `tidyverse`, R Markdown, ShinyⓇ, and  `reticulate`,

    -   [RStudioⓇ Server
        1.4](https://rstudio.com/products/rstudio/download-server/other-platforms/ "Download RStudio Server for other platforms"),

    -   [`libnode-dev`](https://launchpad.net/~cran/+archive/ubuntu/v8 "v8 (libnode) PPA")
        for the `V8` R package,

    -   [`conda-forge`](https://github.com/conda-forge/miniforge "conda-forge/miniforge GitHub repository"),

    plus install scripts for

    -   CUDA-aware [Apache Arrow
        3.0.0](https://arrow.apache.org/docs/ "Apache Arrow documentation")
        (C++, Python and R),
    -   [cuSignal](https://github.com/rapidsai/cusignal),
    -   Julia plus `CUDA.jl`,
    -   R audio, authoring, package development tools, [Bayesian
        statistics](https://github.com/rmcelreath/rethinking), and
        [spatial / civic software
        development](https://geocompr.robinlovelace.net/ "Geocomputation with R"),

    all on a Docker image, then read on!

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

-   some directories on the internal builder images in my build process,
    which reside in the [Docker Hub `edgyr`
    organization](https://hub.docker.com/orgs/edgyr/repositories "Docker Hub edgyr organization").

## Contributing

Contributing to the project is really quite simple:

1.  Read the code of conduct at
    <https://github.com/edgyR/edgyR-containers/blob/master/CODE_OF_CONDUCT.md>.

2.  Everything starts with an issue. See [Always start with an
    issue](https://about.gitlab.com/2016/03/03/start-with-an-issue/) for
    the philosophy.

    -   Is the documentation unclear? [File an
        issue](https://github.com/edgyR/edgyR-containers/issues/new).
    -   Did you find a bug? [File an
        issue](https://github.com/edgyR/edgyR-containers/issues/new).
    -   Do you want to request a feature? [File an
        issue](https://github.com/edgyR/edgyR-containers/issues/new).

*Please, don't go through the mechanics of forking / pull requests even
for trivial typo changes without filing an issue. [File an
issue](https://github.com/edgyR/edgyR-containers/issues/new).*

## [Yes! I want more!](I-want-mode.md)
