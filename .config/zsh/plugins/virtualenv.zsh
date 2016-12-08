#!/usr/bin/env zsh


# Set default VIRTUAL_ENV_HIDDEN_ROOT if not set
[[ ! -z VIRTUAL_ENV_HIDDEN_ROOT ]] && VIRTUAL_ENV_HIDDEN_ROOT=$HOME/.config/virtualenvs


# Tool for easily creating new virtual environments
mkvirtualenv() {
    which virtualenv > /dev/null 2> /dev/null || return

    root=$VIRTUAL_ENV_HIDDEN_ROOT
    if [[ -z $root ]]; then
        root=.
    else
        project_name=$1
        [[ -z $project_name ]] && project_name=$(basename $PWD)
        root=$root/$project_name
    fi

    virtualenv $root
    source $root/bin/activate
    $root/bin/pip install --upgrade pip
    $root/bin/pip install neovim
}


# Acticate virtualenvs when CDing into them. Deactivate then after having left
# the project directory.
activate_virtual_environment() {
    [[ -n $VIRTUAL_ENV && ${PWD:0:${#VIRTUAL_ENV}} != ${VIRTUAL_ENV} ]] && deactivate

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
