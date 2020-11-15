FROM "docker.io/edgyr/internal-r4jetson"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR $SOURCE_DIR

# System-wide installs
COPY install-julia.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/install-julia.sh > $LOGS/install-julia.log 2>&1 \
  && gzip -9 $LOGS/install-julia.log

COPY sympy.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/sympy.sh > $LOGS/sympy.log 2>&1 \
  && gzip -9 $LOGS/sympy.log

COPY edgyr-user.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/edgyr-user.sh > $LOGS/edgyr-user.log 2>&1 \
  && gzip -9 $LOGS/edgyr-user.log

# enable passwordless sudo
COPY passwordless-sudo /etc/sudoers.d/

# set up 'edgyr' account
ENV EDGYR_HOME=/home/edgyr
ENV PROJECT_HOME=$EDGYR_HOME/Projects
ENV EDGYR_SCRIPTS=$EDGYR_HOME/scripts
ENV EDGYR_LOGS=$EDGYR_HOME/logs
ENV EDGYR_PLOTS=$EDGYR_HOME/plots
RUN mkdir --parents $PROJECT_HOME $EDGYR_SCRIPTS $EDGYR_LOGS $EDGYR_PLOTS
RUN chown -R edgyr:edgyr $EDGYR_HOME

USER edgyr
WORKDIR $EDGYR_HOME

COPY --chown=edgyr:edgyr Rprofile $EDGYR_HOME/.Rprofile
COPY --chown=edgyr:edgyr r-packages.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/r-packages.R > $EDGYR_LOGS/r-packages.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/r-packages.log

COPY --chown=edgyr:edgyr test-keras.R $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/test-keras.R > $EDGYR_LOGS/test-keras.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/test-keras.log \
  && mv Rplots.pdf $EDGYR_PLOTS/test-keras.pdf

COPY --chown=edgyr:edgyr miniforge.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/miniforge.sh > $EDGYR_LOGS/miniforge.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/miniforge.log

COPY --chown=edgyr:edgyr configure-julia.sh $EDGYR_SCRIPTS/
RUN /usr/bin/time $EDGYR_SCRIPTS/configure-julia.sh > $EDGYR_LOGS/configure-julia.log 2>&1 \
  && gzip -9 $EDGYR_LOGS/configure-julia.log

COPY --chown=edgyr:edgyr bash_aliases $EDGYR_HOME/.bash_aliases
COPY --chown=edgyr:edgyr start-jupyterlab.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr edit-me-then-run-4-git-config.sh $EDGYR_HOME/
COPY --chown=edgyr:edgyr Installers $EDGYR_HOME/Installers

CMD [ "/home/edgyr/start-jupyterlab.sh" ]
