FROM "docker.io/edgyr/r-jetson"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ENV SOURCE_DIR=/usr/local/src/
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
ENV PACKAGES=$SOURCE_DIR/packages
RUN mkdir --parents $SOURCE_DIR $LOGS $SCRIPTS $PACKAGES

USER root
WORKDIR $SOURCE_DIR

# Julia
ENV JULIA_VERSION_MAJOR=1 JULIA_VERSION_MINOR=5 JULIA_VERSION_PATCH=2
COPY install-julia $SCRIPTS/
RUN $SCRIPTS/install-julia > $LOGS/install-julia.log 2>&1 \
  && gzip -9 $LOGS/install-julia.log

# Linux dependencies for R packages
COPY linux-dependencies $SCRIPTS/
RUN $SCRIPTS/linux-dependencies > $LOGS/linux-dependencies.log 2>&1 \
  && gzip -9 $LOGS/linux-dependencies.log

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

COPY --chown=edgyr:edgyr configure-julia $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/configure-julia > $EDGYR_LOGS/configure-julia.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/configure-julia.log

COPY --chown=edgyr:edgyr miniforge $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/miniforge > $EDGYR_LOGS/miniforge.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/miniforge.log
COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr start-jupyterlab $EDGYR_HOME
COPY --chown=edgyr:edgyr start-opencpu $EDGYR_HOME
COPY --chown=edgyr:edgyr r-packages $EDGYR_SCRIPTS/
RUN $EDGYR_SCRIPTS/r-packages > $EDGYR_LOGS/r-packages.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/r-packages.log
RUN Rscript -e "tinytex::install_tinytex()" > $EDGYR_LOGS/tinytex.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/tinytex.log

EXPOSE 5656
CMD [ "/home/edgyr/start-opencpu" ]
