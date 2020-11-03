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

COPY build-tools sources.list.new $SCRIPTS/
RUN $SCRIPTS/build-tools > $LOGS/build-tools.log 2>&1 \
  && gzip -9 $LOGS/build-tools.log

# make and install the packages
COPY r-base $SCRIPTS/
RUN $SCRIPTS/r-base > $LOGS/r-base.log 2>&1 \
  && gzip -9 $LOGS/r-base.log
COPY r-recommended $SCRIPTS/
RUN $SCRIPTS/r-recommended > $LOGS/r-recommended.log 2>&1 \
  && gzip -9 $LOGS/r-recommended.log

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
RUN mkdir --parents $PROJECT_HOME

COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr Renviron $EDGYR_HOME/.Renviron
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.bash $EDGYR_HOME/
RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME
CMD [ "/bin/bash" ]
