FROM ubuntu:bionic
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

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
COPY --from="edgyr/internal-r-source:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-r-source:latest" /usr/local/lib/R /usr/local/lib/R
COPY --from="edgyr/internal-r-source:latest" /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY --from="edgyr/internal-r-source:latest" /usr/local/lib/libRmath.so /usr/local/lib/libRmath.so
COPY --from="edgyr/internal-r-source:latest" /usr/local/lib/libRmath.a /usr/local/lib/libRmath.a
COPY --from="edgyr/internal-r-source:latest" /usr/local/include /usr/local/include
COPY --from="edgyr/internal-r-source:latest" /usr/local/share/man /usr/local/share/man
COPY --from="edgyr/internal-pandoc-source:latest" /usr/local/bin/pandoc /usr/local/bin/pandoc

COPY R.conf configure.sh $SCRIPTS/
RUN $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1 \
  && gzip -9 $LOGS/configure.log

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
COPY rstudio.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1 \
  && gzip -9 $LOGS/rstudio.log
