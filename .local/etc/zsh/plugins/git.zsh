#!/usr/bin/env zsh

clone() {
    if [[ -z $1 ]]; then
        echo 'Usage: clone [repo name]' > /dev/stderr
        return
    fi

    organization=$(basename ${PWD})
    host=$(basename $(dirname ${PWD}))

    git clone ${host}:${organization}/${1}
}
