#!/usr/bin/env zsh


export PYENV_ROOT
export PYENV_VERSION
export VIRTUAL_ENV_HIDDEN_ROOT


[[ -z $PYENV_ROOT ]] && PYENV_ROOT=${HOME}/.local/share/pyenv
[[ -z $VIRTUAL_ENV_HIDDEN_ROOT ]] && VIRTUAL_ENV_HIDDEN_ROOT=$HOME/.config/virtualenvs

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

  venv_path=$(pipenv --venv 2>/dev/null)
  [[ -z $venv_path ]] && return

  source "${venv_path}/bin/activate"
}


mkenv() {
  which pipenv 2>&1 > /dev/null
  [[ $? != 0 ]] && printf 'Failed: Please install pipenv.\n' > /dev/stderr && return 1

  python_version=$1
  [[ -z ${python_version} ]] && python_version=$(python --version | cut -f 2 -d \ )

  pipenv --python "${python_version}"
  [[ -f setup.py || -f Pipfile.lock ]] && pipenv install --dev 2>&1 > /dev/null

  activate_virtual_environment
}


which pipenv 2>&1 > /dev/null && chpwd_functions=( \
  ${chpwd_functions[@]}                            \
  "activate_virtual_environment"                   \
)

__init_pyenv
