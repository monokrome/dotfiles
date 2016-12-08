#!/usr/bin/env zsh


[[ -z $AVIATION_ROOT ]] && AVIATION_ROOT=http://localhost:8500/


aviation() {
    [[ -z $1 ]] && echo "First argument is required."

    url=${AVIATION_ROOT}${1}/

    query=$@[2,-1]
    [[ ! -z $query ]] && url="${url}?${query}"

    get json $url
}
