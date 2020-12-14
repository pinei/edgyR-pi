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

# pocl from tarball
ENV POCL_VERSION=1.6-RC1
COPY pocl-cuda.sh pocl-cuda-git.sh $SCRIPTS/
#RUN $SCRIPTS/pocl-cuda.sh > $LOGS/pocl-cuda.log 2>&1

# pocl from git repo
ENV GIT_REPO="https://github.com/isuruf/pocl.git"
ENV BRANCH="cuMemHostRegister"
RUN $SCRIPTS/pocl-cuda-git.sh > $LOGS/pocl-cuda-git.log 2>&1

# test with R OpenCL package
COPY OpenCL-R-test.R $SCRIPTS/
RUN $SCRIPTS/OpenCL-R-test.R > $LOGS/OpenCL-R-test.log 2>&1 || true

# run 'pocl' CUDA tests
COPY test-cuda.sh run_cuda_tests $SCRIPTS/
RUN $SCRIPTS/test-cuda.sh 2>&1 | tee $LOGS/test-cuda.log
