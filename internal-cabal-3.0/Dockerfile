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

# upgrade cabal
COPY ram_kilobytes.sh /usr/local/bin/
COPY cabal.sh $SCRIPTS/
RUN $SCRIPTS/cabal.sh > $LOGS/cabal-3.0.log 2>&1
