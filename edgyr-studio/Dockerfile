FROM "docker.io/edgyr/edgyr-lab"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR $SOURCE_DIR/

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
COPY --from=docker.io/edgyr/rstudio-package $PACKAGES/$PACKAGE_FILE $PACKAGES/
RUN tar -xf $PACKAGES/$PACKAGE_FILE --strip-components=1 --directory=/

# configure RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY rstudio-configure.sh $SCRIPTS/
COPY rserver.conf /etc/rstudio/
RUN $SCRIPTS/rstudio-configure.sh

# set entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
