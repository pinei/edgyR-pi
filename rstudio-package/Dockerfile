FROM "docker.io/znmeb/ocpu-jetson"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR $SOURCE_DIR/

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
COPY rstudio-package $SCRIPTS/
RUN $SCRIPTS/rstudio-package > $LOGS/rstudio-package.log 2>&1 \
  && gzip -9 $LOGS/rstudio-package.log
