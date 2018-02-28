#!/usr/bin/env zsh


export PYENV_ROOT
export PYENV_VERSION
export VIRTUAL_ENV_HIDDEN_ROOT


[[ -z $PYENV_ROOT ]] && PYENV_ROOT=${HOME}/.local/share/pyenv
[[ ! -z $VIRTUAL_ENV_HIDDEN_ROOT ]] && VIRTUAL_ENV_HIDDEN_ROOT=$HOME/.config/virtualenvs


path=(${PYENV_ROOT}/bin $path)


__init_pyenv() {
    command -v pyenv 2>&1 > /dev/null || return

    [[ -z $PYENV_VERSION ]] && PYENV_VERSION=$(pyenv versions | tail -n 1 | cut -d \  -f 3)

    init_command=$(pyenv init -)
    eval ${init_command}
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


__init_pyenv
