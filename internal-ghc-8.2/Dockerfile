FROM edgyr/internal-build-dependencies:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# GHC 8.2
ENV GHC_RELEASE=8.2.2
COPY --chown=edgyr:edgyr ghc.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/ghc.sh > $EDGYR_LOGS/ghc-$GHC_RELEASE.log
