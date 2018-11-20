#!/usr/bin/env zsh

setopt autocd
setopt cdsilent

pathfrom() {
  IFS=':'
  shift
  echo "$*"
}


# cdpath=${(0a)cdpath}
export CDPATH=$(pathfrom $HOME/Projects/{*,*/*}(/N))
