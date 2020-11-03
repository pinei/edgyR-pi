FROM "nvcr.io/nvidia/l4t-base:r32.4.4"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src/
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $PACKAGES

USER root
WORKDIR $SOURCE_DIR

COPY build-tools sources.list.new $SCRIPTS/
RUN $SCRIPTS/build-tools > $LOGS/build-tools.log 2>&1 \
  && gzip -9 $LOGS/build-tools.log

# make and install the packages
COPY r-base $SCRIPTS/
RUN $SCRIPTS/r-base > $LOGS/r-base.log 2>&1 \
  && gzip -9 $LOGS/r-base.log
COPY r-recommended $SCRIPTS/
RUN $SCRIPTS/r-recommended > $LOGS/r-recommended.log 2>&1 \
  && gzip -9 $LOGS/r-recommended.log
