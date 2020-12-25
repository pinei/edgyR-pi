FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS
RUN ls -AFlrt $SOURCE_DIR

WORKDIR $SOURCE_DIR

# RAM query script
COPY ram_kilobytes.sh /usr/local/bin/

# build dependencies
COPY build-deps.sh $SCRIPTS/
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1

# cabal-install-3.0
COPY cabal-install-3.0.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal-install-3.0.sh > $LOGS/cabal-install-3.0.log 2>&1

# GHC 8.4
COPY ghc.sh $SCRIPTS/
ENV GHC_VERSION=8.4.4
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-8.4.log 2>&1
