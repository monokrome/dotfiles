#!/usr/bin/env zsh

setopt autocd

# Check if option exists since it's from a custom source change
[[ -o cdsilent ]] && setopt cdsilent

cdpath=( $HOME/Projects/**(/N) )
