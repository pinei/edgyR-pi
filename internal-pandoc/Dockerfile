FROM edgyr/internal-ghc-8.6:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# pandoc
COPY --chown=edgyr:edgyr pandoc.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/pandoc.sh > $EDGYR_LOGS/pandoc.log 2>&1
