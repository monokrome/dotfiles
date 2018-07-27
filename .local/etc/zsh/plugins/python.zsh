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
python__init_pyenv() {
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


python-init() {
  python_executable=$1

  # Use Python3 as default when available
  if [[ ! -n $python_executable ]]; then
    which python3 2>&1 > /dev/null

    if [[ $? == 0 ]]; then
      python_executable=python3
    else
      python_executable=python2
    fi
  else
    python_executable=$(which $python_executable 2>/dev/null)

    if [[ $? == 0 ]]; then
      printf 'Failed to create virtual enviroment. %s is not in your PATH.\n' $python_executable
      return
    fi
  fi

  python_version=$(${python_executable} --version)
  python_major_version=${python_version[0]}

  [[ ! -e "${ENV_ROOT}" ]] && mkdir -p "${ENV_ROOT}"
  venv_path=${ENV_ROOT}/$(basename $PWD)

  printf 'Creating new virtual environment with Python %s in %s\n' $python_version $venv_path

  if [[ ${python_version[0]} == 2 ]]; then
    virtualenv -p ${python_executable} "${venv_path}"
  else
    ${python_executable} -m venv "${venv_path}"
  fi

  [[ ! -z $VIRTUAL_ENV ]] && pip install -U setuptools pip
}


chpwd_functions=("python__activate" ${chpwd_functions[@]})
precmd_functions=("python__activate" ${precmd_functions[@]})


python__init_pyenv
