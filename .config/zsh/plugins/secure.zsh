#!/usr/bin/env zsh


[[ -z $ZSH_CONFIG_PATH ]] && export ZSH_CONFIG_PATH=$HOME/.config/zsh


ZSH_PRIVATE_ENCRYPTED_SUFFIX=.enc
ZSH_PRIVATE_PATH=${ZSH_CONFIG_PATH}/private/


__walk_private() {
    paths=$ZSH_PRIVATE_PATH${@[2,-1]}(N)
    for filename in ${~paths}; do
        $1 $filename
    done
}


__unlock_zsh_configs() {
    output_path=${1[0,-5]}
    openssl enc -d -aes-256-cbc -a -in "${1}" -out "${output_path}"
}


unlock_zsh_configs() {
    if [[ -z $1 ]]; then
        filename='*'
    else
        filename = $1
    fi

    __walk_private __unlock_zsh_configs "${filename}${ZSH_PRIVATE_ENCRYPTED_SUFFIX}"
}


__lock_zsh_configs() {
    filename=$1
    output=${filename}${ZSH_PRIVATE_ENCRYPTED_SUFFIX}
    openssl enc -aes-256-cbc -a -salt -in "${filename}" -out "${output}"
}


lock_zsh_configs() {
    if [[ -e $filename && -e $output ]]; then
        left_modification_time=$(stat -f "%m" ${filename})
        output_modification_time=$(stat -f "%m" ${output})

        [[ $left_modification_time -le $output_modification_time ]] && return 0
    fi

    __walk_private __lock_zsh_configs '*.zsh'
}


zsh_secret() {
    [[ -z ${1} ]] && echo 'Must provide a filename to edit secrets.' && return 1
    [[ -z ${EDITOR} ]] && EDITOR=vim

    filename=${ZSH_PRIVATE_PATH}$1.zsh
    [[ -e ${filename} ]] || unlock_zsh_configs $1

    $EDITOR $filename
}


setup_zsh_secrets() {
    sourceall ${ZSH_CONFIG_PATH}/private/*.zsh(N)
}


setup_zsh_secrets
