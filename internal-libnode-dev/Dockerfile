FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

ENV SOURCE_DIR=/usr/local/src
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV LOGS=$SOURCE_DIR/logs
RUN mkdir --parents $SCRIPTS $LOGS

WORKDIR $SOURCE_DIR
COPY build-deps.sh build-libnode-dev.sh cran-ubuntu-v8-bionic.list sources.list $SCRIPTS/
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1
RUN $SCRIPTS/build-libnode-dev.sh > $LOGS/build-libnode-dev.log 2>&1

# Smoke test!
RUN apt-get install -qqy --no-install-recommends \
  libcurl4-openssl-dev \
  r-base-dev \
  && Rscript -e "install.packages('V8')"

ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $PACKAGES \
  && cp $SOURCE_DIR/*/*.deb $PACKAGES/
