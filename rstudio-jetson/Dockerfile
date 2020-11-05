FROM "docker.io/edgyr/ocpu-jetson"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR $SOURCE_DIR/

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
ENV BUILD_DIR=$SOURCE_DIR/rstudio/build
ENV PACKAGE_FILE=rstudio-server-$RSTUDIO_VERSION_MAJOR.$RSTUDIO_VERSION_MINOR.$RSTUDIO_VERSION_PATCH-arm64.tar.gz
COPY --from=docker.io/edgyr/rstudio-package $BUILD_DIR/$PACKAGE_FILE $SOURCE_DIR
RUN tar -xf $PACKAGE_FILE --strip-components=1 --directory=/

# configure RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY rstudio-configure $SCRIPTS/
COPY rserver.conf /etc/rstudio/
RUN $SCRIPTS/rstudio-configure

# set entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
