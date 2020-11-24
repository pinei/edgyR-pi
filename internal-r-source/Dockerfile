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

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=3
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY r-from-source.sh $SCRIPTS/
RUN $SCRIPTS/r-from-source.sh > $LOGS/r-from-source.log 2>&1 \
  && gzip -9 $LOGS/r-from-source.log
