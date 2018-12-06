#!/usr/bin/env zsh


export NODE_ENV=development


alias node-scripts() {
  [ ! -f package.json ] && return
  cat package.json | jq '.scripts|keys'
}
