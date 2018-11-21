#!/usr/bin/env zsh

export EDITOR=nvim
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_API_TOKEN
export ELECTRON_DEBUG=1
export GPG_TTY=$(tty)

alias vimup="nvim '+PlugUpdate' '+qa'"

path=(/usr/local/bin ${HOME}/.local/bin ${HOME}/.cabal/bin $path)
