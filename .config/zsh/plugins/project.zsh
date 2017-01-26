#!/usr/bin/env zsh


[[ -z $PROJECTS_ROOT ]] && PROJECTS_ROOT=$HOME/Projects/


project() {
    [[ -z $2 ]] && echo 'Usage: clone <organization> <repository>' && exit 1

    organization_directory="${PROJECTS_ROOT}${1}"
    project_directory="${organization_directory}/${2}"

    if [[ ! -d $project_directory ]]; then
        [[ ! -d $organization_directory ]] && mkdir -p $organization_directory

        cd $organization_directory
        git clone github.com:$1/$2
    fi

    cd $project_directory
}
