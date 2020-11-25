FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

# BINARIES is where we put files that could or must be
# installed into /usr/local on a user-level image
ENV BINARIES=/binaries
RUN mkdir --parents \
  $BINARIES/bin \
  $BINARIES/etc \
  $BINARIES/games \
  $BINARIES/include \
  $BINARIES/lib \
  $BINARIES/sbin \
  $BINARIES/share/man \
  $BINARIES/src \
  && ln -s "share/man" $BINARIES/man

ENV SOURCE_DIR=$BINARIES/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS \
  && ls -AlR $BINARIES

WORKDIR $SOURCE_DIR

# build dependencies
COPY build-deps.sh $SCRIPTS/
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1 \
  && gzip -9 $LOGS/build-deps.log

# The Haskell development tools make heavy use of local
# (per-user) build strategy. Running them as 'root' goes
# against the grain, so we create a non-root user to 
# make the code more natural.
COPY edgyr-user.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/edgyr-user.sh > $LOGS/edgyr-user.log 2>&1 \
  && gzip -9 $LOGS/edgyr-user.log

# enable passwordless sudo
COPY passwordless-sudo /etc/sudoers.d/

# set up 'edgyr' account
ENV EDGYR_HOME=/home/edgyr
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV EDGYR_SRC=$EDGYR_HOME/src
ENV EDGYR_SCRIPTS=$EDGYR_HOME/scripts
ENV EDGYR_LOGS=$EDGYR_HOME/logs
ENV EDGYR_PLOTS=$EDGYR_HOME/plots
ENV EDGYR_BIN=$EDGYR_HOME/.cabal/bin
RUN mkdir --parents $PROJECT_HOME $EDGYR_SRC $EDGYR_SCRIPTS $EDGYR_LOGS $EDGYR_PLOTS $EDGYR_BIN
RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME

# GHC 8.2
ENV GHC_RELEASE=8.2.2
COPY --chown=edgyr:edgyr ghc.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/ghc.sh > $EDGYR_LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/ghc-$GHC_RELEASE.log

# upgrade cabal
COPY --chown=edgyr:edgyr cabal.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/cabal.sh > $EDGYR_LOGS/cabal.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/cabal.log

# pandoc
COPY --chown=edgyr:edgyr pandoc.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/pandoc.sh > $EDGYR_LOGS/pandoc.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/pandoc.log
