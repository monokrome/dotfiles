#!/usr/bin/env zsh

setopt autocd

# Check if option exists since it's from a custom source change
setopt cdsilent > /dev/null
cdpath=( ${HOME}/Projects/{*/*,*}(-/N) )

export CDPATH=$CDPATH

# Use exa instead of ls when available
which exa 2>&1 > /dev/null
[[ $? == 0 ]] && alias ls=exa
