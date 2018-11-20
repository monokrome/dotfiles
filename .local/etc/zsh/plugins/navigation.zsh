#!/usr/bin/env zsh

setopt autocd

# Check if option exists since it's from a custom source change
setopt cdsilent > /dev/null

cdpath=( ${HOME}/Projects/{*/*,*}(-/N) )
