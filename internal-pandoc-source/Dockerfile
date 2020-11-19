FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV BINARIES=$SOURCE_DIR/binaries
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $BINARIES

USER root
WORKDIR $SOURCE_DIR

# build dependencies
COPY build-deps.sh $SCRIPTS/
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1 \
  && gzip -9 $LOGS/build-deps.log

# cabal
COPY cabal.sh $SCRIPTS/
RUN $SCRIPTS/cabal.sh > $LOGS/cabal.log 2>&1 \
  && gzip -9 $LOGS/cabal.log

# Pandoc
COPY pandoc.sh $SCRIPTS/
RUN $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1 \
  && gzip -9 $LOGS/pandoc.log
