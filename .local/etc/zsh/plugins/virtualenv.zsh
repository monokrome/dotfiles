#!/usr/bin/env zsh


# Set default VIRTUAL_ENV_HIDDEN_ROOT if not set
[[ ! -z VIRTUAL_ENV_HIDDEN_ROOT ]] && VIRTUAL_ENV_HIDDEN_ROOT=$HOME/.config/virtualenvs


# Tool for easily creating new virtual environments
mkvirtualenv() {
    [[ ! -d $VIRTUAL_ENV_HIDDEN_ROOT ]] && mkdir $VIRTUAL_ENV_HIDDEN_ROOT
    which virtualenv > /dev/null 2> /dev/null || return 1

    root=$VIRTUAL_ENV_HIDDEN_ROOT
    if [[ -z $root ]]; then
        root=.
    else
        project_name=$1
        [[ -z $project_name ]] && project_name=$(basename $PWD)
        root=$root/$project_name
    fi

    if [[ -z $1 ]]; then
        interpretter=python3
    else
        interpretter=python2
    fi

    virtualenv -p ${interpretter} $root
    source $root/bin/activate

    $root/bin/pip install --upgrade pip
    $root/bin/pip install neovim
}


# Acticate virtualenvs when CDing into them. Deactivate then after having left
# the project directory.
activate_virtual_environment() {
    if [[ -n $VIRTUAL_ENV && ${PWD:0:${#VIRTUAL_ENV}} != ${VIRTUAL_ENV} ]]; then
        which deactivate > /dev/null && deactivate
        export VIRTUAL_ENV=
    fi

    current_path=$PWD
    while [ $current_path != "/" ]; do
        venv_bin_path=$VIRTUAL_ENV_HIDDEN_ROOT/$(basename $current_path)/bin
        if [[ -f $venv_bin_path/activate && -f $venv_bin_path/pip ]]; then
            source $venv_bin_path/activate
            return
        fi

        if [[ -f ${current_path}/bin/activate && -f ${current_path}/bin/pip ]]; then
            source ${current_path}/bin/activate
            return
        fi

        current_path=$(dirname $current_path)
    done
}


chpwd_functions=(${chpwd_functions[@]} "activate_virtual_environment")
