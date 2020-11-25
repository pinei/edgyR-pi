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

# boost
COPY install-boost.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/install-boost.sh > $LOGS/install-boost.log 2>&1 \
  && gzip -9 $LOGS/install-boost.log

# R and pandoc
COPY --from="edgyr/internal-r-source:latest" $BINARIES $BINARIES
COPY --from="edgyr/internal-pandoc-source:latest" $BINARIES $BINARIES

COPY R.conf configure.sh $SCRIPTS/
RUN $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1 \
  && gzip -9 $LOGS/configure.log

# "install" RStudio Server to a "binaries" directory
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
COPY rstudio.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1 \
  && gzip -9 $LOGS/rstudio.log

# copy the goods to $BINARIES
COPY publish.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/publish.sh > $LOGS/publish.log 2>&1 \
  && gzip -9 $LOGS/publish.log
