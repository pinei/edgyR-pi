FROM "edgyr/l4t-ml:r32.4.4-tf2.3-py3"
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
USER root

ENV SOURCE_DIR=/usr/local/src
ENV LOGS=$SOURCE_DIR/logs
ENV SCRIPTS=$SOURCE_DIR/scripts
RUN mkdir --parents $LOGS $SCRIPTS

WORKDIR $SOURCE_DIR

# get R, Pandoc and RStudio Server
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/bin /usr/local/bin
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/lib/R /usr/local/lib/R
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/lib/pkgconfig /usr/local/lib/pkgconfig
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/lib/libRmath.so /usr/local/lib/libRmath.so
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/lib/libRmath.a /usr/local/lib/libRmath.a
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/lib/rstudio-server /usr/local/lib/rstudio-server
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/include /usr/local/include
COPY --from="edgyr/internal-rstudio-source:latest" /usr/local/share/man /usr/local/share/man

# Linux dependencies
COPY linux-deps.sh $SCRIPTS/
RUN $SCRIPTS/linux-deps.sh > $LOGS/linux-deps.log 2>&1 \
  && gzip -9 $LOGS/linux-deps.log

# configure R and RStudio Server
# see https://support.rstudio.com/hc/en-us/articles/200552306-Getting-Started
COPY configure-r-rstudio.sh $SCRIPTS/
COPY R.conf /etc/ld.so.conf.d/
COPY rserver.conf /etc/rstudio/
RUN $SCRIPTS/configure-r-rstudio.sh > $LOGS/configure-r-rstudio.log 2>&1 \
  && gzip -9 $LOGS/configure-r-rstudio.log

# install Julia
ENV JULIA_VERSION_MAJOR=1 JULIA_VERSION_MINOR=5 JULIA_VERSION_PATCH=3
COPY install-julia.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/install-julia.sh > $LOGS/install-julia.log 2>&1 \
  && gzip -9 $LOGS/install-julia.log

# SymPy
COPY sympy.sh $SCRIPTS/
RUN /usr/bin/time $SCRIPTS/sympy.sh > $LOGS/sympy.log 2>&1 \
  && gzip -9 $LOGS/sympy.log

# Create the default user
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

# switch back to 'root' for wrap-up
USER root
WORKDIR $SOURCE_DIR/

# set entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
