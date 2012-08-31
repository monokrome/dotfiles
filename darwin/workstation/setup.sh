#!/bin/bash

# Execute common_configurations.sh from the repositories /shared/ directory.
shared_source common_configurations.sh

# Make sure that iTerm2 is set up for our configuration.
current_iterm_configuration_dir=$(defaults read com.googlecode.iterm2 PrefsCustomFolder)
current_directory=$(pwd)

if [[ -e ${current_iterm_configuration_dir} ]]; then
  cd $current_iterm_configuration_dir
fi

if [[ $(pwd) != $current_iterm_configuration_dir ]]; then
  echo '======> Updating iTerm2 configuration...'
  defaults write com.googlecode.iterm2 PrefsCustomFolder ~/.iterm2
fi

cd ${current_directory}

add_configuration .iterm2

# Shut up OS X terminals.
add_configuration .hushlogin

