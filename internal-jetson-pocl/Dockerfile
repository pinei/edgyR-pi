FROM "nvcr.io/nvidia/l4t-base:r32.4.4"
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
COPY build-deps.sh $SCRIPTS/
RUN $SCRIPTS/build-deps.sh > $LOGS/build-deps.log 2>&1

# pocl from git repo
COPY pocl-git-source.sh pocl-build.sh $SCRIPTS/
RUN $SCRIPTS/pocl-git-source.sh > $LOGS/pocl-git-source.log 2>&1
RUN $SCRIPTS/pocl-build.sh > $LOGS/pocl-build.log 2>&1

# test with R OpenCL package
COPY OpenCL-R-test.R $SCRIPTS/
RUN $SCRIPTS/OpenCL-R-test.R > $LOGS/OpenCL-R-test.log 2>&1

# run 'pocl' CUDA tests
COPY test-cuda.sh $SCRIPTS/
RUN $SCRIPTS/test-cuda.sh 2>&1 | tee $LOGS/test-cuda.log

# CSound
ENV CSOUND_VERSION=6.15.0
COPY csound.sh $SCRIPTS/
RUN $SCRIPTS/csound.sh > $LOGS/csound.log 2>&1

# ChucK
ENV CHUCK_VERSION=1.4.0.1
COPY chuck.sh $SCRIPTS/
RUN $SCRIPTS/chuck.sh > $LOGS/chuck.log 2>&1
