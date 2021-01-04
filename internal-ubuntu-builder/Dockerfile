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

# cabal-install-3.0
COPY cabal-install-3.0.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/cabal-install-3.0.sh > $LOGS/cabal-install-3.0.log 2>&1

# pandoc
COPY pandoc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=3
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY r-from-source.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/r-from-source.sh > $LOGS/r-from-source.log 2>&1
COPY configure.sh R.conf $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1

# boost
COPY install-boost.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/install-boost.sh > $LOGS/install-boost.log 2>&1

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
COPY rstudio.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1

COPY build-libnode-dev.sh cran-ubuntu-v8-bionic.list sources.list $SCRIPTS/
RUN $SCRIPTS/build-libnode-dev.sh > $LOGS/build-libnode-dev.log 2>&1
