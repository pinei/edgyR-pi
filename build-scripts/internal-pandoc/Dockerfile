FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN ls -AFlrt $SOURCE_DIR

WORKDIR $SOURCE_DIR

# RAM query script
COPY ram_kilobytes.sh /usr/local/bin/

# build dependencies
COPY build-deps.sh $SCRIPTS/
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1

# ghc 8.2
COPY ghc-8.2.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/ghc-8.2.sh > $LOGS/ghc-8.2.log 2>&1

# cabal-install-3.0
COPY cabal-install-3.0.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal-install-3.0.sh > $LOGS/cabal-install-3.0.log 2>&1

# ghc 8.6
COPY ghc-8.6.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/ghc-8.6.sh > $LOGS/ghc-8.6.log 2>&1

# cabal-install-3.2
COPY cabal-install-3.2.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal-install-3.2.sh > $LOGS/cabal-install-3.2.log 2>&1

# pandoc - version 2.11.2 is hard-coded dependency in RStudio 1.4 source
ENV PANDOC_VERSION=2.11.2
COPY pandoc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1
