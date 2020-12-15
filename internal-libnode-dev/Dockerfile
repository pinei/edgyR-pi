FROM edgyr/internal-rstudio-server:latest

ARG DEBIAN_FRONTEND=noninteractive

ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $PACKAGES

WORKDIR $SOURCE_DIR
COPY build-libnode-dev.sh cran-ubuntu-v8-bionic.list sources.list $SCRIPTS/
RUN $SCRIPTS/build-libnode-dev.sh > $LOGS/build-libnode-dev.log 2>&1
