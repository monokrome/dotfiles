#!/usr/bin/env zsh


which nvim > /dev/null && alias vim=nvim

autoload -U colors && colors


# Show [NORMAL] when not in insert mode
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select


# Vi-like modal editing
bindkey -v
export KEYTIMEOUT=1  # 0.1 seconds of lag after hitting escape


# Use vim completion keys
bindkey '^P' up-history
bindkey '^N' down-history


# backspace and ^h working even after returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char


# CTRL-w to a remove word backwards
bindkey '^w' backward-kill-word


# CTRL-r to start searching history backward
bindkey '^r' history-incremental-search-backward
