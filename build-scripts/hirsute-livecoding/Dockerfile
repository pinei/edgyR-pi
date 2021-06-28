FROM ubuntu:hirsute
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS 
RUN ls -FlarRt /usr/local > $LOGS/before.log

WORKDIR $SOURCE_DIR

# command line requirements
COPY command-line.sh $SCRIPTS/
RUN $SCRIPTS/command-line.sh > $LOGS/command-line.log 2>&1

# assume dark background for vim
RUN echo "set bg=dark" >> /root/.vimrc

# Create the default user
COPY edgyr-user.sh $SCRIPTS/
RUN $SCRIPTS/edgyr-user.sh > $LOGS/edgyr-user.log 2>&1

# enable passwordless sudo
COPY passwordless-sudo /etc/sudoers.d/

# set up 'edgyr' account
ENV EDGYR_HOME=/home/edgyr
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV EDGYR_SCRIPTS=$EDGYR_HOME/scripts
ENV EDGYR_LOGS=$EDGYR_HOME/logs
RUN mkdir --parents \
  $PROJECT_HOME \
  $EDGYR_SCRIPTS \
  $EDGYR_LOGS

# assume dark background for vim
RUN echo "set bg=dark" >> $EDGYR_HOME/.vimrc

RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME

COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr vimrc-* $EDGYR_HOME/

ENV LIBINSTPATCH_VERSION="1.1.6"
ENV FLUIDSYNTH_VERSION="2.2.1"
COPY --chown=edgyr:edgyr Softsynths/fluidsynth.sh $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/fluidsynth.sh > $EDGYR_LOGS/fluidsynth.log 2>&1

ENV PURE_DATA_VERSION="0.51-4"
COPY --chown=edgyr:edgyr Softsynths/pure-data.sh $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/pure-data.sh > $EDGYR_LOGS/pure-data.log 2>&1

ENV FAUST_VERSION="2.30.5"
COPY --chown=edgyr:edgyr Softsynths/faust.sh $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/faust.sh > $EDGYR_LOGS/faust.log 2>&1

ENV SUPERCOLLIDER_VERSION="3.11.2"
ENV SC3_PLUGINS_VERSION="3.11.1"
COPY --chown=edgyr:edgyr Softsynths/supercollider.sh $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/supercollider.sh > $EDGYR_LOGS/supercollider.log 2>&1

ENV CHUCK_VERSION="1.4.1.0"
COPY --chown=edgyr:edgyr Softsynths/chuck.sh $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/chuck.sh > $EDGYR_LOGS/chuck.log 2>&1

ENV CSOUND_VERSION="6.16.0"
COPY --chown=edgyr:edgyr Softsynths/csound.sh $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/csound.sh > $EDGYR_LOGS/csound.log 2>&1

# list installed Apt packages
RUN dpkg --list > $EDGYR_LOGS/installed-packages.log
