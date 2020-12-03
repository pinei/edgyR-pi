FROM edgyr/internal-pandoc:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

USER edgyr
WORKDIR $EDGYR_HOME

# stack
COPY --chown=edgyr:edgyr stack.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/stack.sh > $EDGYR_LOGS/stack.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/stack.log
