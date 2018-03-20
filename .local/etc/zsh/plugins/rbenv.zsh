#!/usr/bin/env zsh

export RBENV_PATH
export RBENV_VERSION

[[ -z $RBENV_VERSION ]] && RBENV_VERSION=2.5.0
[[ -z $RBENV_PATH ]] && RBENV_PATH=${HOME}/.local/share/rbenv
[[ -d $RBENV_PATH ]] && path=(${RBENV_PATH}/bin $path)

which rbenv 2>&1 > /dev/null && eval "$(rbenv init -)"
