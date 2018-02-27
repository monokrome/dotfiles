export PYENV_ROOT
export PYENV_VERSION

[[ -z $PYENV_ROOT ]] && PYENV_ROOT=${HOME}/.local/share/pyenv


path=(${PYENV_ROOT}/bin $path)


__init_pyenv() {
    [[ -z $PYENV_VERSION ]] && PYENV_VERSION=$(pyenv versions | tail -n 1 | cut -d \  -f 3)

    init_command=$(pyenv init -)
    eval ${init_command}
}


command -v pyenv 2>&1 > /dev/null && __init_pyenv
