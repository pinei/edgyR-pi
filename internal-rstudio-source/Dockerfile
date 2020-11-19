FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV BINARIES=$SOURCE_DIR/binaries
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $BINARIES

ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093

USER root
WORKDIR $SOURCE_DIR

# build dependencies
COPY build-deps.sh $SCRIPTS/
RUN echo $SCRIPTS $LOGS $PACKAGES $PACKAGE_FILE
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1 \
  && gzip -9 $LOGS/build-deps.log

# boost
COPY install-boost.sh $SCRIPTS/
RUN echo $SCRIPTS $LOGS $PACKAGES $PACKAGE_FILE
RUN $SCRIPTS/install-boost.sh > $LOGS/install-boost.log 2>&1 \
  && gzip -9 $LOGS/install-boost.log

# "install" RStudio Server to a "binaries" directory
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
COPY rstudio.sh $SCRIPTS/
RUN echo $SCRIPTS $LOGS $PACKAGES $PACKAGE_FILE
RUN $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1 \
  && gzip -9 $LOGS/rstudio.log
