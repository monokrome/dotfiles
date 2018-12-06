#!/usr/bin/env zsh


nocorrect_file="${ZSH_CONFIG_PATH}/nocorrect"


if [ -f "${nocorrect_file}" ]; then
    while read -r command; do
        if [ $command ]; then
            alias $command="nocorrect $command"
        fi
    done < ${nocorrect_file}
fi

