FROM "nvcr.io/nvidia/cuda:latest"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS
RUN ls -AFlrt $SOURCE_DIR

WORKDIR $SOURCE_DIR

# build dependencies
COPY build-deps.sh cran.list $SCRIPTS/
ENV RSTUDIO_PACKAGE="https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.4.1087-amd64.deb"
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1

# test with R OpenCL package
COPY OpenCL-R-test.R $SCRIPTS/
RUN $SCRIPTS/OpenCL-R-test.R > $LOGS/OpenCL-R-test.log 2>&1
