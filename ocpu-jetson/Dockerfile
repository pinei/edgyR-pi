FROM "nvcr.io/nvidia/l4t-base:r32.4.4"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src/
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $PACKAGES

USER root
WORKDIR $SOURCE_DIR

ENV R_VERSION_MAJOR=4 R_VERSION_MINOR=0 R_VERSION_PATCH=3
ENV R_LATEST=R-$R_VERSION_MAJOR.$R_VERSION_MINOR.$R_VERSION_PATCH
COPY r-from-source R.conf $SCRIPTS/
RUN $SCRIPTS/r-from-source > $LOGS/r-from-source.log 2>&1 \
  && gzip -9 $LOGS/r-from-source.log

# create admin user with 'sudo' privilege
RUN useradd \
  --shell /bin/bash \
  --user-group \
  --groups adm,audio,cdrom,dip,i2c,plugdev,sudo,video \
  --create-home \
  --uid 1000 edgyr \
  && echo "edgyr:edgyr" | chpasswd

# enable passwordless sudo
COPY passwordless-sudo /etc/sudoers.d/

# set up 'edgyr' account
ENV EDGYR_HOME=/home/edgyr
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV EDGYR_SCRIPTS=$EDGYR_HOME/scripts
ENV EDGYR_LOGS=$EDGYR_HOME/logs
RUN mkdir --parents $PROJECT_HOME $EDGYR_SCRIPTS $EDGYR_LOGS

COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr Renviron $EDGYR_HOME/.Renviron
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.bash $EDGYR_HOME/
RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME
COPY --chown=edgyr:edgyr install-opencpu start-opencpu $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/install-opencpu > $EDGYR_LOGS/install-opencpu.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/install-opencpu.log

EXPOSE 5656
CMD [ "/home/edgyr/scripts/start-opencpu" ]
