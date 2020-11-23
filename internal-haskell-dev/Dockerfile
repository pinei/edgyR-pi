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

# GHC 8.2
ENV GHC_RELEASE=8.2.2
COPY ghc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# cabal
COPY cabal.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal.sh > $LOGS/cabal.log 2>&1 \
  && gzip -9 $LOGS/cabal.log

# pandoc
COPY pandoc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1 \
  && gzip -9 $LOGS/pandoc.log

# GHC 8.6
ENV GHC_RELEASE=8.6.5
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# GHC 8.8
ENV GHC_RELEASE=8.8.4
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log
