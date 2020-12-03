FROM edgyr/internal-cabal-3.2:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# GHC 8.8
ENV GHC_RELEASE=8.8.4
COPY --chown=edgyr:edgyr ghc.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/ghc.sh > $EDGYR_LOGS/ghc-$GHC_RELEASE.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/ghc-$GHC_RELEASE.log
