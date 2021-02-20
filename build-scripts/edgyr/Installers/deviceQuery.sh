#! /bin/bash

set -e

# We know $HOME/bin is in our PATH - TinyTeX put it there!
if [ ! -d $PROJECT_HOME/samples ]
then
  echo "Copying '/usr/local/samples' to '$PROJECT_HOME/'"
  cp -rp /usr/local/cuda/samples $PROJECT_HOME/
fi

if [ ! -x $EDGYR_HOME/bin/deviceQuery ]
then
  echo "Compiling 'deviceQuery"
  pushd $PROJECT_HOME/samples/1_Utilities/deviceQuery
  make >> $EDGYR_LOGS/deviceQuery.log
  echo "Installing 'deviceQuery' in '$HOME/bin'"
  cp deviceQuery $HOME/bin/
  popd
fi

$HOME/bin/deviceQuery
