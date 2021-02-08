# edgyR-containers: Docker Images for NVIDIAⓇ Jetson™ R Developers

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
    is first-class, and the developer support forum will fill in the
    blanks. For hardware hacking, the
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

    Because JetPack includes the NVIDIA Docker runtime, it can run all
    of the images in the [NVIDIA NGC L4T container
    catalog](https://ngc.nvidia.com/catalog/containers?orderBy=scoreDESC&pageNumber=0&query=L4T&quickFilter=containers&filters= "NVIDIA NGC container catalog")
    (for security, link opens in a new window).

3.  ***If you're a Python programmer, or an R programmer that can live
    with `R version 3.4.4 (2018-03-15) -- "Someone to Lean On"` and
    `pandoc 1.19.2.4` from the command line, you're done!*** Just about
    everything you'd ever want is available via `docker run` or
    `sudo apt install` in Linux, and `install.packages` or
    `devtools::install` in R.

    If you want more - `arm64` binaries downloaded from upstream
    projects or built from upstream source for

    -   newer `pandoc`,

    -   newer R with `tidyverse`, `devtools`, R Markdown, ShinyⓇ, and
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

    -   R audio, authoring, Bayesian statistics, and spatial / civic
        software development,

    all on a Docker image, then read on!
