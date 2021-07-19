FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $LOGS $SCRIPTS $PACKAGES
RUN ls -FlarRt /usr/local > $LOGS/before.log

WORKDIR $SOURCE_DIR

# assume dark background for vim
RUN echo "set bg=dark" >> /root/.vimrc

# RAM query script
COPY ram_kilobytes.sh /usr/local/bin/

# Pandoc
ENV PANDOC_VERSION="2.14.1"
COPY upstream-pandoc.sh $SCRIPTS/
RUN $SCRIPTS/upstream-pandoc.sh > $LOGS/upstream-pandoc.log 2>&1

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=1 R_VERSION_PATCH=0
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY r-from-source.sh $SCRIPTS/
RUN $SCRIPTS/r-from-source.sh > $LOGS/r-from-source.log 2>&1
COPY configure.sh R.conf $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1

# PGDG repository
COPY pgdg.sh pgdg.list $SCRIPTS/
RUN $SCRIPTS/pgdg.sh > $LOGS/pgdg.log 2>&1

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=4 RSTUDIO_VERSION_PATCH=1717
COPY rstudio.sh $SCRIPTS/
COPY dependencies/linux $SCRIPTS/dependencies/linux
COPY dependencies/common $SCRIPTS/dependencies/common
RUN /usr/bin/time $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1

COPY build-libnode-dev.sh cran-ubuntu-v8-bionic.list sources.list $SCRIPTS/
RUN $SCRIPTS/build-libnode-dev.sh > $LOGS/build-libnode-dev.log 2>&1

# gforth
ENV GFORTH_VERSION="0.7.3"
COPY gforth.sh $SCRIPTS/
RUN $SCRIPTS/gforth.sh > $LOGS/gforth.log 2>&1

RUN ls -FlarRt /usr/local > $LOGS/after.log
