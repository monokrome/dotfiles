#!/usr/bin/env zsh


autoload -U colors && colors


[[ -z $PROJECTS_ROOT ]] && PROJECTS_ROOT=$HOME/Projects/


__project_prepare_golang() {
    [[ -z $GOPATH ]] && return 0

    # Wipe out golang source directory if we are cloning a project that isn't
    # in the projects directory.
    go_src_project_path=${GOPATH}/src/github.com/$2/$3/
    [[ ! -d $go_src_project_path ]] && return 0

    print -P "%F{white}Cleaning up old source path for new files.%f"
    rm -rf $go_src_project_path
}


__project_prepare() {
    __project_prepare_golang $@
}


__project_init_python() {
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


__project_init_ruby() {
    [[ -f Gemfile ]] && bundle install
    return 0
}


__npm_or_yarn_install() {
    # Prefer yarn over NPM, but failover to NPM.
    which yarn 2> /dev/null > /dev/null
    yarn_missiong=$?

    [[ $yarn_missiong == 0 ]] && yarn install $@ && return 0

    print -P '%F{cyan}Could not find yarn or install failed. Trying via npm.%f'
    npm install $@
}


__project_init_node() {
    [[ -f package.json ]] && npm_or_yarn_install
    [[ -f bower.json ]] && bower install
}


__project_init_golang() {
    [[ -z $GOPATH ]] && return 0

    go_files=$(find . -iname \*.go)
    [[ -z $go_files ]] && return 0

    go_src_organization_path=${GOPATH}/src/github.com/$2/
    go_src_project_path=${go_src_organization_path}${3}/

    if [[ ! -d $go_src_project_path ]]; then
        [[ -d $go_src_organization_path ]] || mkdir -p $go_src_organization_path
        mv $1 $go_src_project_path
        ln -s $go_src_project_path $1
    fi

    go list > /dev/null 2> /dev/null && go get .
}


__project_init_make() {
    [[ -f CMakeLists.txt ]] && cmake .
    [[ -f configure.ac ]] && autoreconf --install
    [[ -f configure ]] && ./configure
    [[ -f Makefile ]] && make
}


__project_init() {
    print -P "%F{cyan}Initializing project at ${1}%f"

    __project_init_golang $@ &&
    __project_init_make $@ &&
    __project_init_python $@ &&
    __project_init_node $@ &&
    __project_init_ruby $@
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

    __project_prepare $project_directory $organization $repository

    git clone github.com:$organization/$repository
    cd $project_directory

    __project_init $project_directory $organization $repository
}
