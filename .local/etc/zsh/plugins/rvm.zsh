#!/usr/bin/env zsh

rvm_default_path="${HOME}/.rvm/"

[[ -z "${RVM_PATH}" && -d ${rvm_default_path}/scripts ]] && RVM_PATH=${rvm_default_path}
[[ ! -z ${RVM_PATH} && -d ${RVM_PATH}/scripts ]] && source ${RVM_PATH}

which rvm 2>&1 > /dev/null && rvm use ruby --latest --default 2>&1 > /dev/null
