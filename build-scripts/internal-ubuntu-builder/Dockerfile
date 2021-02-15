FROM edgyr/internal-pandoc:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

WORKDIR $SOURCE_DIR

# R
ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=4
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY r-from-source.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/r-from-source.sh > $LOGS/r-from-source.log 2>&1
COPY configure.sh R.conf $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/configure.sh > $LOGS/configure.log 2>&1

# PGDG repository
COPY pgdg.sh pgdg.list $SCRIPTS/
RUN $SCRIPTS/pgdg.sh > $LOGS/pgdg.log 2>&1

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=4 RSTUDIO_VERSION_PATCH=1103
COPY rstudio.sh $SCRIPTS/
COPY dependencies/linux $SCRIPTS/dependencies/linux
COPY dependencies/common $SCRIPTS/dependencies/common
RUN /usr/bin/time $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1
COPY vim-dark /root/.vimrc

COPY build-libnode-dev.sh cran-ubuntu-v8-bionic.list sources.list $SCRIPTS/
RUN $SCRIPTS/build-libnode-dev.sh > $LOGS/build-libnode-dev.log 2>&1

# hugo
ENV GOLANG_VERSION="1.15.8"
COPY hugo.sh $SCRIPTS/
RUN $SCRIPTS/hugo.sh > $LOGS/hugo.log 2>&1
