FROM edgyr/internal-cabal-3.0:latest
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root
WORKDIR $SOURCE_DIR

# pandoc dependencies only
COPY ram_kilobytes.sh /usr/local/bin/
COPY pandoc-deps.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/pandoc-deps.sh > $LOGS/pandoc-deps.log 2>&1
