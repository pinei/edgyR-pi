# edgyR-containers: Docker Images for NVIDIAⓇ Jetson™ R Developers

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
        `arm64`architecure,

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

    -   R 4.0.3 with `tidyverse`, `devtools`, R Markdown, ShinyⓇ, and
        `reticulate`,

    -   [RStudioⓇ Server
        1.4](https://rstudio.com/products/rstudio/download-server/other-platforms/ "Download RStudio Server for other platforms"),

    -   [`libnode-dev`](https://launchpad.net/~cran/+archive/ubuntu/v8 "v8 (libnode) PPA")
        for the `V8` R package,

    -   [`conda-forge`](https://github.com/conda-forge/miniforge "conda-forge/miniforge GitHub repository"),
        Jupyter Lab, [CuPy](https://cupy.dev/ "CuPy website") and
        [`cuSignal`](https://github.com/rapidsai/cusignal "cusignal GitHub repository"),

    plus install scripts for

    -   CUDA-aware PyTorch, TensorFlow, [Apache Arrow
        3.0.0](https://arrow.apache.org/docs/ "Apache Arrow documentation")
        (C++, Python and R), [Portable Computing
        Language](http://portablecl.org/docs/html/ "Portable Computing Language documentation"),
        and Julia,

    -   R audio, authoring, [Bayesian
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

## Getting started

1.  Open a command line terminal on the Jetson. Clone this repository:
    `git clone https://github.com/edgyR/edgyR-containers.git`. `cd` into
    `edgyR-containers`.

2.  `./pull.sh`. This will download the [edgyR
    image](https://hub.docker.com/r/edgyr/edgyr "edgyR image on Docker Hub")
    from Docker Hub.

3.  The `edgyR` image ships with an administrative user named `edgyr`.
    This user has *passwordless* `sudo` privileges. So you should
    *never* host the image on the public internet. *Never, ever, ever,
    ever! Don't do that! Really!*

    On your home / lab LAN, you'll need to define a strong password for
    this user. To do that, type

        export EDGYR_PASSWORD="at-least-twelve-characters-easy-to-remember-and-hard-to-guess"

4.  Type `./run.sh`. This will remove any existing `edgyr` container and
    start a new one using the `edgyr` image. Notes:

    -   The container connects to the Docker `host` network. This means
        it has the same internet connectivity as your Jetson. That
        should be OK in a home environment, but in a lab setting, make
        sure you clear it with your LAN administrator.
    -   The RStudio server listens on IP address:port `0.0.0.0:7878`.
        This means you can browse to it on the Jetson as
        `localhost:7878` and from any other system on the LAN as
        `<Jetson IP address>:7878`. Note that this is a different port
        than the RStudio Server default, 8787.

5.  Browse to the server, either on the Jetson as `localhost` or from
    another machine on the LAN. Log in as `edgyr` with the password you
    set in step 3 above. You will be in the RStudio Server desktop.
    Enjoy!
