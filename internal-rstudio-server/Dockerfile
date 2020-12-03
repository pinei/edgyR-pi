FROM edgyr/internal-build-dependencies:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER root
WORKDIR $SOURCE_DIR

# boost
COPY install-boost.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/install-boost.sh

# R and pandoc
COPY --from="edgyr/internal-r:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-r:latest" /usr/local/lib/R /usr/local/lib/R
COPY --from="edgyr/internal-r:latest" /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY --from="edgyr/internal-r:latest" /usr/local/lib/libRmath.so /usr/local/lib/libRmath.so
COPY --from="edgyr/internal-r:latest" /usr/local/lib/libRmath.a /usr/local/lib/libRmath.a
COPY --from="edgyr/internal-r:latest" /usr/local/include /usr/local/include
COPY --from="edgyr/internal-r:latest" /usr/local/share/man /usr/local/share/man
COPY --from="edgyr/internal-pandoc:latest" /usr/local/bin/pandoc /usr/local/bin/pandoc

COPY R.conf configure.sh $SCRIPTS/
RUN $SCRIPTS/configure.sh

# install RStudio Server
# see https://rstudio.com/products/rstudio/download-server/other-platforms/
ENV RSTUDIO_VERSION_MAJOR=1 RSTUDIO_VERSION_MINOR=3 RSTUDIO_VERSION_PATCH=1093
COPY rstudio.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/rstudio.sh
