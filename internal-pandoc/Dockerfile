FROM edgyr/internal-cabal-install:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
WORKDIR $SOURCE_DIR

# pandoc dependencies
ENV PANDOC_VERSION=2.11.3.1
COPY pandoc-deps.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc-deps.sh > $LOGS/pandoc-deps.log 2>&1

# pandoc
COPY pandoc.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc.sh > $LOGS/pandoc.log 2>&1
