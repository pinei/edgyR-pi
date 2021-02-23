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
