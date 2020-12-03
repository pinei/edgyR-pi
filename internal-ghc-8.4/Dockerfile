FROM edgyr/internal-cabal-3.0:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# GHC 8.4
ENV GHC_RELEASE=8.4.4
COPY --chown=edgyr:edgyr ghc.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/ghc.sh
