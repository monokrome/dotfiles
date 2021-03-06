#!/usr/bin/env zsh


autoload -U colors && colors


set_prompt() {
    previous_command_code=$?

    PS2=' ->   '
    PS1="%n@%M "

    [[ $previous_command_code != 0 ]] && PS1="%F{red}${PS1}%f"

    PS1="$PS1%# "

    GIT_REF="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
    [[ $GIT_REF != "" ]] && PS1="$PS1%F{cyan}($vcs_info_msg_0_)%f "

    if [[ $VIRTUAL_ENV != "" ]]; then
        basename=$(basename $VIRTUAL_ENV)
        PS1="%F{cyan}(${basename})%f $PS1"
    fi
}


precmd_functions+=(${precmd_functions[@]} "set_prompt")
