#!/usr/bin/env zsh

cdpaths=(${HOME}/Projects/* ${HOME}/Projects/*/*); for p in $cdpaths; do
  if [[ -z $CDPATH ]]; then
    CDPATH="$p"
  else
    CDPATH="${CDPATH}:$p"
  fi
done && unset cdpaths
