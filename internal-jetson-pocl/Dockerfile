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

# pocl with CUDA back end
ENV POCL_VERSION=1.6-RC1
COPY pocl-cuda.sh pocl.conf $SCRIPTS/
RUN $SCRIPTS/pocl-cuda.sh > $LOGS/pocl-cuda.log 2>&1

# test with R OpenCL package
COPY OpenCL-R-test.R $SCRIPTS/
RUN $SCRIPTS/OpenCL-R-test.R > $LOGS/OpenCL-R-test.log 2>&1

# run 'pocl' CUDA tests
COPY test-cuda.sh $SCRIPTS/
RUN $SCRIPTS/test-cuda.sh
