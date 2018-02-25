#!/usr/bin/env zsh

# Show CDM if performing a text-mode login on TTY1
if [[ "$(tty)" == '/dev/tty1' && -f "$HOME/.cdmrc" ]]; then
    cdm=which cdm 2> /dev/null || return

    [[ -n "$CDM_SPAWN" ]] && return
    [[ -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ]] && exec $cdm
fi
