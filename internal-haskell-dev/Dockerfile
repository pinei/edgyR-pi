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

# stack
#COPY stack.sh $SCRIPTS/
#RUN $SCRIPTS/stack.sh > $LOGS/stack.log 2>&1 \
  #&& gzip -9 $LOGS/stack.log

# newer GHC
#ENV GHC_RELEASE=8.4.4
#COPY ghc.sh $SCRIPTS/
#RUN $SCRIPTS/ghc.sh > $LOGS/ghc.log 2>&1 \
  #&& gzip -9 $LOGS/ghc.log
