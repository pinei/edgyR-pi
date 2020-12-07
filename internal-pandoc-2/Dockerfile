FROM edgyr/internal-pandoc-1:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# pandoc-2
COPY --chown=edgyr:edgyr pandoc-2.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/pandoc-2.sh > $EDGYR_LOGS/pandoc-2.log 2>&1
