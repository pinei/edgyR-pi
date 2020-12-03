FROM edgyr/internal-ghc-8.2:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# upgrade cabal
COPY --chown=edgyr:edgyr cabal.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/cabal.sh
