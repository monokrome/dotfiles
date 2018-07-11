#!/usr/bin/env zsh

export GOPATH=${HOME}/.local/share/go

[[ ! -e ${GOPATH} ]] && mkdir -p ${GOPATH}

path=($GOPATH/bin $path)
