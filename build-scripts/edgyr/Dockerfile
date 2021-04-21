FROM "nvcr.io/nvidia/l4t-ml:r32.5.0-py3"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

# reset entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN ls -FlarRt /usr/local > $LOGS/before.log

WORKDIR $SOURCE_DIR

# assume dark background for vim
RUN echo "set bg=dark" >> /root/.vimrc

# get packages from builder image
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/etc /usr/local/etc
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/games /usr/local/games
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/include /usr/local/include
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/lib /usr/local/lib
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/man /usr/local/man
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/sbin /usr/local/sbin
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/share /usr/local/share
COPY --from="edgyr/internal-ubuntu-builder:latest" /usr/local/src/packages /usr/local/src/packages

# Linux dependencies
COPY command-line.sh pgdg.list $SCRIPTS/
RUN $SCRIPTS/command-line.sh > $LOGS/command-line.log 2>&1

COPY libraries.sh $SCRIPTS/
RUN $SCRIPTS/libraries.sh > $LOGS/libraries.log 2>&1

COPY cusignal.sh $SCRIPTS/
RUN $SCRIPTS/cusignal.sh > $LOGS/cusignal.log 2>&1

COPY libnode-dev.sh $SCRIPTS/
RUN $SCRIPTS/libnode-dev.sh > $LOGS/libnode-dev.log 2>&1

# configure R and RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY configure.sh $SCRIPTS/
COPY R.conf /etc/ld.so.conf.d/
COPY rserver.conf /etc/rstudio/
RUN $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1

# Create the default user
COPY edgyr-user.sh $SCRIPTS/
RUN $SCRIPTS/edgyr-user.sh > $LOGS/edgyr-user.log 2>&1

# enable passwordless sudo
COPY passwordless-sudo /etc/sudoers.d/

# set up 'edgyr' account
ENV EDGYR_HOME=/home/edgyr
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV WORKON_HOME=$EDGYR_HOME/.virtualenvs
ENV EDGYR_SCRIPTS=$EDGYR_HOME/scripts
ENV EDGYR_LOGS=$EDGYR_HOME/logs
ENV EDGYR_PLOTS=$EDGYR_HOME/plots
ENV EDGYR_NOTEBOOKS=$EDGYR_HOME/notebooks
RUN mkdir --parents \
  $PROJECT_HOME \
  $WORKON_HOME \
  $EDGYR_SCRIPTS \
  $EDGYR_LOGS \
  $EDGYR_PLOTS \
  $EDGYR_NOTEBOOKS

# assume dark background for vim
RUN echo "set bg=dark" >> $EDGYR_HOME/.vimrc

RUN cp -rp /usr/local/share/cusignal-notebooks $EDGYR_NOTEBOOKS/
RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME

COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr Renviron $EDGYR_HOME/.Renviron

COPY --chown=edgyr:edgyr install-tinytex.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/install-tinytex.R > $EDGYR_LOGS/install-tinytex.R.log 2>&1

COPY --chown=edgyr:edgyr r-depends.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/r-depends.sh > $EDGYR_LOGS/r-depends.sh.log 2>&1

COPY --chown=edgyr:edgyr r-packages.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/r-packages.R > $EDGYR_LOGS/r-packages.R.log 2>&1

COPY --chown=edgyr:edgyr miniforge.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/miniforge.sh > $EDGYR_LOGS/miniforge.log 2>&1

COPY --chown=edgyr:edgyr audio.sh audio.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/audio.sh > $EDGYR_LOGS/audio.log 2>&1

COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr Installers $EDGYR_HOME/Installers
COPY --chown=edgyr:edgyr Softsynths $EDGYR_HOME/Softsynths
COPY --chown=edgyr:edgyr vimrc-* $EDGYR_HOME/
COPY --chown=edgyr:edgyr start-jupyter-lab.sh $EDGYR_HOME/
RUN apt list --installed > $EDGYR_LOGS/installed-packages.log

# switch back to 'root' for wrap-up
USER root
WORKDIR $SOURCE_DIR/
RUN ls -FlarRt /usr/local > $LOGS/after.log
