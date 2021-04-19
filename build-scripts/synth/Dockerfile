FROM "edgyr/edgyr:latest"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR $SOURCE_DIR
RUN ls -FlarRt /usr/local > $LOGS/before.log

COPY command-line-audio.sh $SCRIPTS/
RUN $SCRIPTS/command-line-audio.sh

COPY chuck.sh $SCRIPTS/
ENV CHUCK_VERSION="1.4.0.1"
RUN $SCRIPTS/chuck.sh

COPY audio.sh audio.R $SCRIPTS/
RUN $SCRIPTS/audio.sh

RUN ls -FlarRt /usr/local > $LOGS/after.log

USER edgyr
WORKDIR $EDGYR_HOME
