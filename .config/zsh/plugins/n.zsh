#!/usr/bin/env zsh

[[ -z $N_PREFIX ]] && export N_PREFIX=${HOME}/.config/n
[[ ! -e $N_PREFIX ]] && mkdir -p $N_PREFIX

export path=("${N_PREFIX}/bin" $path)
which n > /dev/null 2> /dev/null && n latest
