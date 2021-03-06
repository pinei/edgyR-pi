FROM "ubuntu:bionic"  
LABEL maintainer="Pinei <aldinei@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN ls -FlarRt /usr/local > $LOGS/before.log

WORKDIR $SOURCE_DIR

# assume dark background for vim
RUN echo "set bg=dark" >> /root/.vimrc

# get binaries from builder image
COPY --from="pinei/internal-r-builder:latest" /usr/local/R /usr/local/R
COPY --from="pinei/internal-r-builder:latest" /usr/local/bin /usr/local/bin
COPY --from="pinei/internal-r-builder:latest" /usr/local/db /usr/local/db
COPY --from="pinei/internal-r-builder:latest" /usr/local/etc /usr/local/etc
COPY --from="pinei/internal-r-builder:latest" /usr/local/extras /usr/local/extras
COPY --from="pinei/internal-r-builder:latest" /usr/local/games /usr/local/games
COPY --from="pinei/internal-r-builder:latest" /usr/local/include /usr/local/include
COPY --from="pinei/internal-r-builder:latest" /usr/local/lib /usr/local/lib
COPY --from="pinei/internal-r-builder:latest" /usr/local/man /usr/local/man
COPY --from="pinei/internal-r-builder:latest" /usr/local/resources /usr/local/resources
COPY --from="pinei/internal-r-builder:latest" /usr/local/sbin /usr/local/sbin
COPY --from="pinei/internal-r-builder:latest" /usr/local/share /usr/local/share
COPY --from="pinei/internal-r-builder:latest" /usr/local/src/logs /usr/local/src/logs
COPY --from="pinei/internal-r-builder:latest" /usr/local/src/packages /usr/local/src/packages
COPY --from="pinei/internal-r-builder:latest" /usr/local/src/scripts /usr/local/src/scripts
COPY --from="pinei/internal-r-builder:latest" /usr/local/www /usr/local/www
COPY --from="pinei/internal-r-builder:latest" /usr/local/www-symbolmaps /usr/local/www-symbolmaps

# Linux dependencies
COPY command-line.sh pgdg.list $SCRIPTS/
RUN $SCRIPTS/command-line.sh > $LOGS/command-line.log 2>&1

COPY libraries.sh $SCRIPTS/
RUN $SCRIPTS/libraries.sh > $LOGS/libraries.log 2>&1

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

RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME

COPY --chown=edgyr:edgyr miniforge.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/miniforge.sh > $EDGYR_LOGS/miniforge.log 2>&1

COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr Renviron $EDGYR_HOME/.Renviron

COPY --chown=edgyr:edgyr tinytex.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/tinytex.R > $EDGYR_LOGS/tinytex.log 2>&1

COPY --chown=edgyr:edgyr r-depends.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/r-depends.sh > $EDGYR_LOGS/r-depends.log 2>&1

COPY --chown=edgyr:edgyr r-packages.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/r-packages.R > $EDGYR_LOGS/r-packages.log 2>&1

COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr Installers $EDGYR_HOME/Installers
COPY --chown=edgyr:edgyr vimrc-* $EDGYR_HOME/
RUN apt list --installed > $EDGYR_LOGS/installed-packages.log

# switch back to 'root' for wrap-up
USER root
WORKDIR $SOURCE_DIR/
RUN ls -FlarRt /usr/local > $LOGS/after.log

# reset entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]

# versions of optional components
ENV JULIA_VERSION_MAJOR=1
ENV JULIA_VERSION_MINOR=6
ENV JULIA_VERSION_PATCH=2
ENV CSOUND_VERSION="6.16.1"
ENV FAUST_VERSION="2.30.5"
ENV CHUCK_VERSION="1.4.1.0"
ENV SUPERCOLLIDER_VERSION="3.11.2"
ENV SC3_PLUGINS_VERSION="3.11.1"
ENV GOLANG_VERSION="1.16.6"
ENV ARROW_VERSION="4.0.1"
ENV LIBINSTPATCH_VERSION="1.1.6"
ENV GFORTH_VERSION="0.7.3"
