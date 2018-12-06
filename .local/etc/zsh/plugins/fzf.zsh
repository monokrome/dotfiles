alias fzf='fzf --height 60% --reverse'

export FZF_DEFAULT_COMMAND='ag --hidden --follow -U --ignore-dir .git -g "" -H '
export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
