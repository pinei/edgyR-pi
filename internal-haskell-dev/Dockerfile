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

# the GHC that ships with Ubuntu Bionic is 8.0. While
# it works, it's very slow, partly because it uses
# gcc as a backend. So we bootstrap a newer one
# first. 8.2.2 is the newest we can use with the
# 'cabal' in Ubuntu Bionic.
ENV GHC_RELEASE=8.2.2
COPY ghc.sh $SCRIPTS/
RUN $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# cabal 3.0
COPY cabal-3.0.sh $SCRIPTS/
RUN $SCRIPTS/cabal-3.0.sh > $LOGS/cabal-3.0.log 2>&1 \
  && gzip -9 $LOGS/cabal-3.0.log

# now we can upgrade to GHC 8.6
ENV GHC_RELEASE=8.6.5
COPY ghc.sh $SCRIPTS/
RUN $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# cabal 3.2
COPY cabal-3.2.sh $SCRIPTS/
RUN $SCRIPTS/cabal-3.2.sh > $LOGS/cabal-3.2.log 2>&1 \
  && gzip -9 $LOGS/cabal-3.2.log

# now we can upgrade to GHC 8.10
ENV GHC_RELEASE=8.10.2
COPY ghc.sh $SCRIPTS/
RUN $SCRIPTS/ghc.sh > $LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $LOGS/ghc-$GHC_RELEASE.log

# stack
COPY stack.sh $SCRIPTS/
RUN $SCRIPTS/stack.sh > $LOGS/stack.log 2>&1 \
  && gzip -9 $LOGS/stack.log

# pandoc
COPY pandoc.sh $SCRIPTS/
RUN $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1 \
  && gzip -9 $LOGS/pandoc.log
