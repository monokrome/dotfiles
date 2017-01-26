#!/usr/bin/env zsh


[[ -z $AVIATION_ROOT ]] && AVIATION_ROOT=http://localhost:8500/


aviation() {
    [[ -z $1 ]] && echo "First argument is required."

    url=${AVIATION_ROOT}${1}/

    query=$@[2,-1]
    [[ ! -z $query ]] && url="${url}?${query}"

    get json $url
}


up() {
    [[ -f docker-compose.yml ]] && return $(docker-compose up)
    [[ -f package.json ]] && return $(npm start)

    echo 'No known method for starting this service.'
    return 1
}
