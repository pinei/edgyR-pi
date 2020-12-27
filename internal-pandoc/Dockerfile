FROM edgyr/internal-cabal-install:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
WORKDIR $SOURCE_DIR

# pandoc
COPY pandoc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1
