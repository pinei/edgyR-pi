FROM edgyr/internal-pandoc:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
WORKDIR $SOURCE_DIR

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=3
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY r-from-source.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/r-from-source.sh > $LOGS/r-from-source.log 2>&1
COPY configure.sh R.conf $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1
