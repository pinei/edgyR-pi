FROM "nvcr.io/nvidia/l4t-base:r32.4.4"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

# get R, Pandoc and RStudio Server
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/lib/R /usr/local/lib/R
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/lib/libRmath.so /usr/local/lib/libRmath.so
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/lib/libRmath.a /usr/local/lib/libRmath.a
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/lib/rstudio-server /usr/local/lib/rstudio-server
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/include /usr/local/include
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/share/man /usr/local/share/man

# libnode-dev and dependencies packages
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/src/packages /usr/local/src/packages

# enable fetching package sources
COPY sources.list /etc/apt/sources.list

# Linux dependencies
COPY linux-deps.sh $SCRIPTS/
RUN $SCRIPTS/linux-deps.sh > $LOGS/linux-deps.log 2>&1 \
  && gzip -9 $LOGS/linux-deps.log
COPY libnode-dev.sh $SCRIPTS/
RUN $SCRIPTS/libnode-dev.sh > $LOGS/libnode-dev.log 2>&1 \
  && gzip -9 $LOGS/libnode-dev.log
COPY youtube-dl.sh $SCRIPTS/
RUN $SCRIPTS/youtube-dl.sh > $LOGS/youtube-dl.log 2>&1 \
  && gzip -9 $LOGS/youtube-dl.log

# PyTorch-1.7
COPY PyTorch-1.7.sh test-pytorch.py $SCRIPTS/
RUN $SCRIPTS/PyTorch-1.7.sh > $LOGS/PyTorch-1.7.log 2>&1 \
  && gzip -9 $LOGS/PyTorch-1.7.log

# configure R and RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY configure.sh $SCRIPTS/
COPY R.conf /etc/ld.so.conf.d/
COPY rserver.conf /etc/rstudio/
RUN $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1 \
  && gzip -9 $LOGS/configure.log

# Create the default user
COPY edgyr-user.sh $SCRIPTS/
RUN $SCRIPTS/edgyr-user.sh > $LOGS/edgyr-user.log 2>&1 \
  && gzip -9 $LOGS/edgyr-user.log

# enable passwordless sudo
COPY passwordless-sudo /etc/sudoers.d/

# install RAM query script globally
COPY ram_kilobytes.sh /usr/local/bin/

# set up 'edgyr' account
ENV EDGYR_HOME=/home/edgyr
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV WORKON_HOME=$EDGYR_HOME/.virtualenvs
ENV EDGYR_SCRIPTS=$EDGYR_HOME/scripts
ENV EDGYR_LOGS=$EDGYR_HOME/logs
ENV EDGYR_PLOTS=$EDGYR_HOME/plots
RUN mkdir --parents $PROJECT_HOME $WORKON_HOME $EDGYR_SCRIPTS $EDGYR_LOGS $EDGYR_PLOTS
RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME

COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr miniforge.sh cusignal_jetson_base.yml $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/miniforge.sh > $EDGYR_LOGS/miniforge.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/miniforge.log

COPY --chown=edgyr:edgyr r-packages.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/r-packages.R > $EDGYR_LOGS/r-packages.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/r-packages.log

ENV JULIA_VERSION_MAJOR=1 JULIA_VERSION_MINOR=5 JULIA_VERSION_PATCH=3
COPY --chown=edgyr:edgyr julia.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/julia.sh > $EDGYR_LOGS/julia.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/julia.log

COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr start-jupyter-lab.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr Installers $EDGYR_HOME/Installers

# switch back to 'root' for wrap-up
USER root
WORKDIR $SOURCE_DIR/

# set entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
