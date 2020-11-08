FROM "docker.io/edgyr/r-jetson"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR $SOURCE_DIR

# package RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
COPY rstudio-package $SCRIPTS/
RUN echo $SCRIPTS $LOGS $PACKAGES $PACKAGE_FILE
RUN $SCRIPTS/rstudio-package > $LOGS/rstudio-package.log 2>&1 \
  && gzip -9 $LOGS/rstudio-package.log
