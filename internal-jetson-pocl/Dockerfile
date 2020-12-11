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
