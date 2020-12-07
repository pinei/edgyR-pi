FROM edgyr/internal-cabal-3.0:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# pandoc-1
ENV PANDOC_VERSION_MAJOR=2 PANDOC_VERSION_MINOR=11 PANDOC_VERSION_PATCH=2
ENV PANDOC_VERSION="pandoc-$PANDOC_VERSION_MAJOR.$PANDOC_VERSION_MINOR.$PANDOC_VERSION_PATCH"
COPY --chown=edgyr:edgyr pandoc-1.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/pandoc-1.sh > $EDGYR_LOGS/pandoc-1.log 2>&1
