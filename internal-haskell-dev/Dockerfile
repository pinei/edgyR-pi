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

# cabal 3.0
COPY cabal-3.0.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal-3.0.sh > $LOGS/cabal-3.0.log 2>&1 \
  && gzip -9 $LOGS/cabal-3.0.log

# GHC 8.4
ENV GHC_RELEASE=8.4.4
COPY ghc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# GHC 8.8
ENV GHC_RELEASE=8.6.5
COPY ghc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# cabal 3.2
COPY cabal-3.2.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal-3.2.sh > $LOGS/cabal-3.2.log 2>&1 \
  && gzip -9 $LOGS/cabal-3.2.log

# GHC 8.10
ENV GHC_RELEASE=8.10.2
COPY ghc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# stack
COPY stack.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/stack.sh > $LOGS/stack.log 2>&1 \
  && gzip -9 $LOGS/stack.log

# pandoc
COPY pandoc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1 \
  && gzip -9 $LOGS/pandoc.log
