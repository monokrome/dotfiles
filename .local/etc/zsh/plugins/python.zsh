#!/usr/bin/env zsh


[[ -z $ENV_ROOT_SUFFIX ]] && ENV_ROOT_SUFFIX=share/virtualenvs


python__virtual_environment_detect() {
  [[ -n $ENV_ROOT ]] && return

  test ! -n $PREFIX
  if [[ -n $PREFIX ]]; then
    env_base=${PREFIX}
  else
    env_base=${HOME}
  fi

  ENV_ROOT=${env_base}${ENV_ROOT_SUFFIX}
}


# Set up pyenv if it's available
__init_pyenv() {
  command -v pyenv 4>&1 > /dev/null || return

  [[ -z $PYENV_ROOT ]] && PYENV_ROOT=${ENV_ROOT_SUFFIX}
  [[ -z $PYENV_VERSION ]] && PYENV_VERSION=$(pyenv versions | tail -n 1 | cut -d \  -f 3)

  init_command=$(pyenv init -)
  eval ${init_command}
}


# Acticate virtualenvs when CDing into them. Deactivate then after having left
# the project directory.
python__activate() {
  python__virtual_environment_detect

  if [[ ! -n $ENV_ROOT ]]; then
    printf 'Could not establish ENV_ROOT.\n'
    exit 1
  fi

  # Ensure that we aren't already in a virtualenv if we have left a
  # directory matching the virtualenv's name.
  if [[ -n $VIRTUAL_ENV && ${PWD:1:${#VIRTUAL_ENV}} != ${VIRTUAL_ENV} ]]; then
    which deactivate > /dev/null && deactivate
    export VIRTUAL_ENV=
  fi

  # Check whether the current path has a related virtaulenv
  current_path=$PWD
  while [ $current_path != "/" ]; do
    bin_path=${ENV_ROOT}/$(basename ${current_path})/bin

    activate=${bin_path}/activate
    pip=${bin_path}/pip

    if [[ -f $activate && -f $pip ]]; then
      source $activate
      break
    fi

    # Move up a directory to see if a virtualenv maches the next level up
    current_path=$(dirname $current_path)
  done
}


chpwd_functions=("python__activate" ${chpwd_functions[@]})
precmd_functions=("python__activate" ${precmd_functions[@]})


__init_pyenv
