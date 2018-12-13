#!/usr/bin/env zsh


[[ $(uname -s 2>/dev/null) == Darwin ]] && install_local_plugin || ignore_local_plugin
