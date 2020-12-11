FROM edgyr/internal-r:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
WORKDIR $SOURCE_DIR

# boost
COPY install-boost.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/install-boost.sh > $LOGS/install-boost.log 2>&1

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
COPY rstudio.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/rstudio.sh > $LOGS/rstudio.log 2>&1
