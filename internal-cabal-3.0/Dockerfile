FROM edgyr/internal-build-dependencies:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# upgrade cabal
COPY --chown=edgyr:edgyr cabal.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/cabal.sh > $EDGYR_LOGS/cabal.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/cabal.log
