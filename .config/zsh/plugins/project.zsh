#!/usr/bin/env zsh


autoload -U colors && colors


[[ -z $PROJECTS_ROOT ]] && PROJECTS_ROOT=$HOME/Projects/


project_init_python() {
    [[ ! -f setup.py && ! -f requirements.txt ]] && return 0

    if [[ -z $VIRTUAL_ENV ]]; then
        print -P '%F{cyan}Not in virtualenv. Activating now.%f'
        activate_virtual_environment
    fi

    if [[ -z $VIRTUAL_ENV ]]; then
        print -P '%F{cyan}Could not activate virtual environment. Creating new one.%f'
        mkvirtualenv
    fi

    if [[ -z $VIRTUAL_ENV ]]; then
        print -P '%F{red} Activating virtual environment for dependencies failed.%f'
        return 1
    fi

    [[ -f setup.py ]] && pip install -e .
    [[ -f requirements.txt ]] && pip install -r requirements.txt
}


project_init_ruby() {
    [[ -f Gemfile ]] && bundle install
}


npm_or_yarn_install() {
    # Prefer yarn over NPM, but failover to NPM.
    which yarn 2> /dev/null > /dev/null
    yarn_missiong=$?

    [[ $yarn_missiong == 0 ]] && yarn install $@ && return 0

    print -P '%F{cyan}Could not find yarn or install failed. Trying via npm.%f'
    npm install $@
}


project_init_node() {
    [[ -f package.json ]] && npm_or_yarn_install
    [[ -f bower.json ]] && bower install
}


project_init_golang() {
    go list > /dev/null 2> /dev/null || return 0
    go get .
}


project_init_make() {
    [[ -f CMakeLists.txt ]] && cmake .
    [[ -f configure.ac ]] && autoreconf --install
    [[ -f configure ]] && ./configure
    [[ -f Makefile ]] && make
}


project_init() {
    project_init_make &&
    project_init_python &&
    project_init_node &&
    project_init_ruby &&
    project_init_golang
}


project() {
    organization=$1
    [[ -z $organization ]] && print -P '%F{red}Usage: $0 <organization> [repository]%f' && return 1

    repository=$2
    [[ -z $repository ]] && repository=$organization

    organization_directory="${PROJECTS_ROOT}${organization}"
    project_directory="${organization_directory}/${repository}"

    [[ -d $project_directory ]] && cd $project_directory && return 0

    [[ ! -d $organization_directory ]] && mkdir -p $organization_directory
    cd $organization_directory

    git clone github.com:$organization/$repository
    cd $project_directory

    # TODO: Preparation steps.
    # For instance, Golang wants all it's packages in the same directory.

    project_init
}
