#!/usr/bin/env zsh

export N_PREFIX=${HOME}/.local/share/n
[[ -z NODE_VERSION ]] && export NODE_VERSION=lts

# n is very slow, so we do this async in a subshell
( which n 2>&1 > /dev/null && n ${NODE_VERSION} 2>&1 > /dev/null & )

alias npm="PREFIX=${HOME}/.local npm"
