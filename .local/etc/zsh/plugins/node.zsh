#!/usr/bin/env zsh


export NODE_ENV=development


function node-scripts() {
  if [[ ! -f package.json ]]; then
    echo 'No package.json in current directory' > /dev/stderr
  else
    cat package.json | jq '.scripts|keys'
  fi
}
