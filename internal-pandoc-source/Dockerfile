FROM ubuntu:groovy
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $PACKAGES

USER root
WORKDIR $SOURCE_DIR

# Pandoc
COPY pandoc-from-source.sh $SCRIPTS/
RUN $SCRIPTS/pandoc-from-source.sh > $LOGS/pandoc-from-source.log 2>&1 \
  && gzip -9 $LOGS/pandoc-from-source.log

COPY publish-pandoc.sh $SCRIPTS/
RUN $SCRIPTS/publish-pandoc.sh > $LOGS/publish-pandoc.log 2>&1 \
  && gzip -9 $LOGS/publish-pandoc.log
