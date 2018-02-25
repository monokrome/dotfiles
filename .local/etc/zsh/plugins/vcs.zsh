#!/usr/bin/env zsh


autoload -U vcs_info


zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:git*' formats "%b"


precmd_functions+=("vcs_info" ${precmd_functions[@]})
