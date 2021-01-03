FROM "nvcr.io/nvidia/l4t-pytorch:r32.4.4-pth1.6-py3"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

# get R, Pandoc and RStudio Server
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/lib/R /usr/local/lib/R
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/lib/libRmath.so /usr/local/lib/libRmath.so
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/lib/libRmath.a /usr/local/lib/libRmath.a
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/lib/rstudio-server /usr/local/lib/rstudio-server
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/include /usr/local/include
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/share/man /usr/local/share/man

# libnode-dev / dependencies packages
COPY --from="edgyr/internal-libnode-dev:latest" /usr/local/src/packages /usr/local/src/packages

# POCL with CUDA backend and CSound with CUDA opcodes
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/etc /usr/local/etc
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/include /usr/local/include

COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libcsnd6.so /usr/local/lib/libcsnd6.so
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libcsnd6.so.6.0 /usr/local/lib/libcsnd6.so.6.0
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libcsound64.a /usr/local/lib/libcsound64.a
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libcsound64.so /usr/local/lib/libcsound64.so
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libcsound64.so.6.0 /usr/local/lib/libcsound64.so.6.0
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libpocl.so.2.7.0 /usr/local/lib/libpocl.so.2.7.0
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libpocl.so.2 /usr/local/lib/libpocl.so.2
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/libpocl.so /usr/local/lib/libpocl.so
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/csound /usr/local/lib/csound
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/pocl /usr/local/lib/pocl
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/python2.7 /usr/local/lib/python2.7
COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/lib/python3.6 /usr/local/lib/python3.6

COPY --from="edgyr/internal-jetson-pocl:latest" /usr/local/share /usr/local/share
COPY --from="edgyr/internal-jetson-pocl:latest" /etc/OpenCL/vendors/pocl.icd /etc/OpenCL/vendors/pocl.icd

# enable fetching package sources
COPY sources.list /etc/apt/sources.list

# Linux dependencies
COPY linux-deps.sh $SCRIPTS/
RUN $SCRIPTS/linux-deps.sh > $LOGS/linux-deps.log 2>&1 \
  && gzip -9 $LOGS/linux-deps.log

# configure R and RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY configure-r-rstudio-pocl.sh $SCRIPTS/
COPY R.conf pocl.conf /etc/ld.so.conf.d/
COPY rserver.conf /etc/rstudio/
RUN $SCRIPTS/configure-r-rstudio-pocl.sh > $LOGS/configure-r-rstudio-pocl.log 2>&1 \
  && gzip -9 $LOGS/configure-r-rstudio-pocl.log

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
