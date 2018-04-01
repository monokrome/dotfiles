#!/usr/bin/env zsh

export N_PREFIX=${HOME}/.local/share/n

n_initialize() {
    n stable 2>&1 > /dev/null
}

which n 2>&1 > /dev/null && n_initialize
