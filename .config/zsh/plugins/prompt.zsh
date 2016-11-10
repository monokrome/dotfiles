autoload -U colors && colors


set_prompt() {
    previous_command_code=$?

    PS2=' ->   '
    PS1="%n@%M "

    if [[ $previous_command_code != 0 ]]; then
        PS1="${fg[red]}${PS1}${reset_color}"
    fi

    PS1="$PS1%# "

    GIT_REF="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
    [[ $GIT_REF != "" ]] && PS1="$PS1${fg[cyan]}($vcs_info_msg_0_)${reset_color} "
    [[ $VIRTUAL_ENV != "" ]] && PS1="${fg[cyan]}($(basename $VIRTUAL_ENV))${reset_color} $PS1"
}

precmd_functions+=(${precmd_functions[@]} "set_prompt")

