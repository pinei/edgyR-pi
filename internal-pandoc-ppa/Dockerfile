FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $PACKAGES

USER root
WORKDIR $SOURCE_DIR

COPY build-tools.sh sources.list.new $SCRIPTS/
RUN $SCRIPTS/build-tools.sh > $LOGS/build-tools.log 2>&1 \
  && gzip -9 $LOGS/build-tools.log

# make and install the packages
COPY level-1.sh $SCRIPTS/
RUN $SCRIPTS/level-1.sh > $LOGS/level-1.log 2>&1 \
  && gzip -9 $LOGS/level-1.log
COPY level-2.sh $SCRIPTS/
RUN $SCRIPTS/level-2.sh > $LOGS/level-2.log 2>&1 \
  && gzip -9 $LOGS/level-2.log
COPY pandoc.sh $SCRIPTS/
RUN $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1 \
  && gzip -9 $LOGS/pandoc.log
